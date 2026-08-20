class FareBreakupModel {
  final double tripFare;
  final double distanceCharge;
  final double loadingUnloadingCharge;
  final double platformFee;
  final double taxes;
  final double discount;

  const FareBreakupModel({
    required this.tripFare,
    required this.distanceCharge,
    required this.loadingUnloadingCharge,
    required this.platformFee,
    required this.taxes,
    required this.discount,
  });

  double get subtotal =>
      tripFare +
      distanceCharge +
      loadingUnloadingCharge +
      platformFee +
      taxes;

  double get total => subtotal - discount;
}