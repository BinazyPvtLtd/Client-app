enum OrderStatus {
  onTheWay,
  delivered,
  cancelled,
}

class OrderModel {
  final String id;

  final String vehicleName;

  final String dateTime;

  final String pickup;

  final String drop;

  final double fare;

  final OrderStatus status;

  const OrderModel({
    required this.id,
    required this.vehicleName,
    required this.dateTime,
    required this.pickup,
    required this.drop,
    required this.fare,
    required this.status,
  });
}