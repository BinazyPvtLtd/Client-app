import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_text_styles.dart';
import 'package:client_app/features/account/saved_addresses/data/models/create_address_request.dart';
import 'package:client_app/features/account/saved_addresses/data/repositories/addresses_repository.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalController = TextEditingController();
  // final _latitudeController = TextEditingController();
  // final _longitudeController = TextEditingController();

  final _repository = AddressesRepository();

  String _label = 'Home';
  bool _isSaving = false;

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalController.dispose();

    super.dispose();
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator ?? _requiredValidator,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
        ),
      ),
    );
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    // final latitude = double.tryParse(_latitudeController.text.trim());
    // final longitude = double.tryParse(_longitudeController.text.trim());

    // if (latitude == null ||
    //     longitude == null ||
    //     !latitude.isFinite ||
    //     !longitude.isFinite ||
    //     latitude < -90 ||
    //     latitude > 90 ||
    //     longitude < -180 ||
    //     longitude > 180) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Enter valid location coordinates')),
    //   );
    //   return;
    // }

    setState(() => _isSaving = true);

    try {
      final request = CreateAddressRequest(
        label: _label,
        addressLine: _addressController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        postalCode: _postalController.text.trim(),
        // latitude: latitude,
        // longitude: longitude,
      );

      await _repository.createAddress(request);

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Unable to save address')));
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Add New Address', style: AppTextStyles.screenTitle),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
          children: [
            Text('Address Type', style: AppTextStyles.heading3),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              value: _label,
              items: ['Home', 'Work', 'Other']
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _label = value);
                }
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildField(label: 'Full Address', controller: _addressController),
            _buildField(label: 'City', controller: _cityController),
            _buildField(label: 'State', controller: _stateController),
            _buildField(
              label: 'PIN Code',
              controller: _postalController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null ||
                    !RegExp(r'^[0-9]{6}$').hasMatch(value.trim())) {
                  return 'Enter a valid 6-digit PIN code';
                }
                return null;
              },
            ),
            // Text(
            //   'Location Coordinates (Testing)',
            //   style: AppTextStyles.heading3,
            // ),
            // const SizedBox(height: AppSpacing.md),
            // _buildField(
            //   label: 'Latitude',
            //   controller: _latitudeController,
            //   keyboardType: const TextInputType.numberWithOptions(
            //     decimal: true,
            //     signed: true,
            //   ),
            // ),
            // _buildField(
            //   label: 'Longitude',
            //   controller: _longitudeController,
            //   keyboardType: const TextInputType.numberWithOptions(
            //     decimal: true,
            //     signed: true,
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
          child: SizedBox(
            height: AppSpacing.buttonHeight,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _saveAddress,
              child: _isSaving
                  ? const CircularProgressIndicator(color: AppColors.white)
                  : Text('Save Address', style: AppTextStyles.buttonText),
            ),
          ),
        ),
      ),
    );
  }
}
