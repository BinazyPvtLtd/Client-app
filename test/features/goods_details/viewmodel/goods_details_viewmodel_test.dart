import 'package:client_app/features/goods_details/viewmodel/goods_details_viewmodel.dart';
import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GoodsDetailsViewModel viewModel;

  setUp(() {
    final vehicle = VehicleModel(
      name: 'Two Wheeler',
      price: '—',
      maxWeight: '20 kg',
      arriving: 'ETA unavailable',
      image: '',
      capacityKg: 20,
    );

    viewModel = GoodsDetailsViewModel(selectedVehicle: vehicle);
  });

  tearDown(() {
    viewModel.dispose();
  });

  test('Empty fields should disable Continue', () {
    expect(viewModel.canContinue, false);
  });

  test('Valid goods details should enable Continue', () {
    viewModel.weightController.text = '10';
    viewModel.packageController.text = '2';
    viewModel.valueController.text = '1000';

    expect(viewModel.canContinue, true);
  });

  test('Weight above vehicle capacity should be rejected', () {
    viewModel.weightController.text = '25';
    viewModel.packageController.text = '2';
    viewModel.valueController.text = '1000';

    expect(viewModel.canContinue, false);
    expect(viewModel.weightError, contains('20 kg'));
  });

  test('Invalid packages should be rejected', () {
    viewModel.weightController.text = '10';
    viewModel.packageController.text = '2.5';
    viewModel.valueController.text = '1000';

    expect(viewModel.canContinue, false);
    expect(viewModel.packagesError, isNotNull);
  });

  test('Invalid goods value should be rejected', () {
    viewModel.weightController.text = '10';
    viewModel.packageController.text = '2';
    viewModel.valueController.text = '-100';

    expect(viewModel.canContinue, false);
    expect(viewModel.goodsValueError, isNotNull);
  });
}
