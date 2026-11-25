import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_text_styles.dart';
import 'package:client_app/features/account/saved_addresses/data/models/create_address_request.dart';
import 'package:client_app/features/account/saved_addresses/data/repositories/addresses_repository.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class AddAddressScreen extends StatefulWidget {
  final String? addressId;

  const AddAddressScreen({
    super.key,
    this.addressId,
  });

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalController = TextEditingController();

  final _repository = AddressesRepository();

  String _label = 'Home';

  bool _isSaving = false;
  bool _isLoading = false;

  String? _loadError;

  bool get _isEditMode => widget.addressId != null;

  @override
  void initState() {
    super.initState();

    if (_isEditMode) {
      _loadAddressDetails();
    }
  }

  // =====================================================
  // GET SINGLE ADDRESS FOR EDIT
  // =====================================================

  Future<void> _loadAddressDetails() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });

    try {
      debugPrint(
        '========== LOAD ADDRESS FOR EDIT ==========',
      );

      final response = await _repository.getAddressById(
        widget.addressId!,
      );

      final rawData = response['data'];

      if (rawData is! Map) {
        throw const FormatException(
          'Invalid address details response',
        );
      }

      final data = Map<String, dynamic>.from(rawData);

      if (!mounted) return;

      _addressController.text =
          data['address_line']?.toString() ?? '';

      _cityController.text =
          data['city']?.toString() ?? '';

      _stateController.text =
          data['state']?.toString() ?? '';

     _postalController.text =
    (data['pincode'] ?? data['postal_code'])
        ?.toString() ?? '';

      final savedLabel =
          data['label']?.toString() ?? 'Home';

      _label = ['Home', 'Work', 'Other'].firstWhere(
        (item) =>
            item.toLowerCase() ==
            savedLabel.toLowerCase(),
        orElse: () => 'Other',
      );

      debugPrint(
        'ADDRESS DETAILS LOADED: $data',
      );
    } catch (error) {
      debugPrint(
        'LOAD ADDRESS DETAILS ERROR: $error',
      );

      if (!mounted) return;

      _loadError = _getErrorMessage(error);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // =====================================================
  // VALIDATION
  // =====================================================

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    return null;
  }

  // =====================================================
  // ERROR MESSAGE
  // =====================================================

  String _getErrorMessage(Object error) {
    if (error is DioException) {
      final data = error.response?.data;

      if (data is Map) {
        final message = data['message'];

        if (message != null) {
          return message.toString();
        }

        final errors = data['errors'];

        if (errors is Map && errors.isNotEmpty) {
          final firstError = errors.values.first;

          if (firstError is List &&
              firstError.isNotEmpty) {
            return firstError.first.toString();
          }

          return firstError.toString();
        }
      }

      return error.message ??
          'Network error. Please try again.';
    }

    return error.toString();
  }

  // =====================================================
  // INPUT FIELD
  // =====================================================

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.lg,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator ?? _requiredValidator,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusMedium,
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // CREATE / UPDATE ADDRESS
  // =====================================================

  Future<void> _saveAddress() async {
  if (_isSaving || _isLoading) return;

  if (!_formKey.currentState!.validate()) return;

  setState(() => _isSaving = true);

  try {
    debugPrint('========== ADDRESS SAVE START ==========');

    double? latitude;
    double? longitude;

    // Coordinates are required when creating an address.
    // For editing, preserve existing coordinates on the server.
    if (!_isEditMode) {
      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location permission is required to save your current location.',
        );
      }

      final serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception(
          'Please enable location services.',
        );
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      latitude = position.latitude;
      longitude = position.longitude;

      debugPrint('LATITUDE: $latitude');
      debugPrint('LONGITUDE: $longitude');
    }

    if (_isEditMode) {
      final payload = {
        'label': _label,
        'address_line': _addressController.text.trim(),
        'city': _cityController.text.trim(),
        'state': _stateController.text.trim(),
        'pincode': _postalController.text.trim(),
      };

      debugPrint('========== UPDATE ADDRESS API ==========');
      debugPrint('REQUEST: $payload');

      await _repository.updateAddressApi(
        id: widget.addressId!,
        payload: payload,
      );

      debugPrint('ADDRESS UPDATED SUCCESSFULLY');
    } else {
      final payload = <String, dynamic>{
        'label': _label,
        'address_line': _addressController.text.trim(),
        'city': _cityController.text.trim(),
        'state': _stateController.text.trim(),
        'pincode': _postalController.text.trim(),
        'latitude': latitude,
        'longitude': longitude,
      };

      debugPrint('========== CREATE ADDRESS API ==========');
      debugPrint('REQUEST: $payload');

      await _repository.createAddressApi(payload);

      debugPrint('ADDRESS CREATED SUCCESSFULLY');
    }

    if (!mounted) return;

    Navigator.pop(context, true);
  } catch (error) {
    debugPrint('SAVE ADDRESS ERROR: $error');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_getErrorMessage(error)),
      ),
    );
  } finally {
    if (mounted) {
      setState(() => _isSaving = false);
    }
  }
}
  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalController.dispose();

    super.dispose();
  }

  // =====================================================
  // UI
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text(
          _isEditMode
              ? 'Edit Address'
              : 'Add New Address',
          style: AppTextStyles.screenTitle,
        ),
      ),

      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _loadError != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          _loadError!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TextButton(
                        onPressed: _loadAddressDetails,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(
                      AppSpacing.screenHorizontal,
                    ),
                    children: [
                      Text(
                        'Address Type',
                        style: AppTextStyles.heading3,
                      ),

                      const SizedBox(
                        height: AppSpacing.md,
                      ),

                      DropdownButtonFormField<String>(
                        value: _label,
                        items: ['Home', 'Work', 'Other']
                            .map(
                              (item) =>
                                  DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _label = value;
                            });
                          }
                        },
                        decoration:
                            const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(
                        height: AppSpacing.xl,
                      ),

                      _buildField(
                        label: 'Full Address',
                        controller: _addressController,
                      ),

                      _buildField(
                        label: 'City',
                        controller: _cityController,
                      ),

                      _buildField(
                        label: 'State',
                        controller: _stateController,
                      ),

                      _buildField(
                        label: 'PIN Code',
                        controller: _postalController,
                        keyboardType:
                            TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              !RegExp(r'^[0-9]{6}$')
                                  .hasMatch(value.trim())) {
                            return 'Enter a valid 6-digit PIN code';
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            AppSpacing.screenHorizontal,
          ),
          child: SizedBox(
            height: AppSpacing.buttonHeight,
            child: ElevatedButton(
              onPressed:
                  (_isSaving || _isLoading || _loadError != null)
                      ? null
                      : _saveAddress,
              child: _isSaving
                  ? const CircularProgressIndicator(
                      color: AppColors.white,
                    )
                  : Text(
                      _isEditMode
                          ? 'Update Address'
                          : 'Save Address',
                      style: AppTextStyles.buttonText,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}