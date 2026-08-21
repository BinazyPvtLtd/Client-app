import 'package:client_app/features/orders/model/order_model.dart';
import 'package:flutter/material.dart';


enum OrderFilter {
  ongoing,
  completed,
  cancelled,
}

class OrdersViewModel extends ChangeNotifier {
  // =========================================================
  // FILTER
  // =========================================================

  OrderFilter _selectedFilter =
      OrderFilter.ongoing;

  OrderFilter get selectedFilter =>
      _selectedFilter;

  // =========================================================
  // BOTTOM NAVIGATION
  // =========================================================

  int _selectedBottomNavIndex = 1;

  int get selectedBottomNavIndex =>
      _selectedBottomNavIndex;

  // =========================================================
  // DUMMY ORDERS
  // =========================================================

  final List<OrderModel> _orders = const [
    OrderModel(
      id: '#PG-982734',
      vehicleName: 'Mini Truck (Tata Ace)',
      dateTime: '15 Aug, 10:15 AM',
      pickup: '12, HSR Layout, Sector 6',
      drop: '45, Industrial Area, Okhla',
      fare: 450,
      status: OrderStatus.onTheWay,
    ),

    OrderModel(
      id: '#PG-981122',
      vehicleName: '2 Wheeler',
      dateTime: '14 Aug, 03:30 PM',
      pickup: 'Indiranagar, 100ft Rd',
      drop: 'Koramangala, 4th Block',
      fare: 120,
      status: OrderStatus.delivered,
    ),

    OrderModel(
      id: '#PG-980055',
      vehicleName: 'Pickup Truck',
      dateTime: '12 Aug, 09:00 AM',
      pickup: 'Whitefield, ITPL',
      drop: 'Hebbal, Flyover',
      fare: 320,
      status: OrderStatus.cancelled,
    ),
  ];

  // =========================================================
  // FILTERED ORDERS
  // =========================================================

  List<OrderModel> get filteredOrders {
    switch (_selectedFilter) {
      case OrderFilter.ongoing:
        return _orders
            .where(
              (order) =>
                  order.status ==
                      OrderStatus.onTheWay,
            )
            .toList();

      case OrderFilter.completed:
        return _orders
            .where(
              (order) =>
                  order.status ==
                      OrderStatus.delivered,
            )
            .toList();

      case OrderFilter.cancelled:
        return _orders
            .where(
              (order) =>
                  order.status ==
                      OrderStatus.cancelled,
            )
            .toList();
    }
  }

  // =========================================================
  // CHANGE FILTER
  // =========================================================

  void changeFilter(
    OrderFilter filter,
  ) {
    if (_selectedFilter == filter) {
      return;
    }

    _selectedFilter = filter;

    notifyListeners();
  }

  // =========================================================
  // BOTTOM NAVIGATION
  // =========================================================

  void changeBottomNavigation(
    int index,
  ) {
    if (_selectedBottomNavIndex == index) {
      return;
    }

    _selectedBottomNavIndex = index;

    notifyListeners();

    debugPrint(
      'Bottom nav index: $index',
    );

    // Later:
    // Home / Offers / Payments / Account navigation
  }

  // =========================================================
  // MENU
  // =========================================================

  void openMenu(
    BuildContext context,
  ) {
    debugPrint('Open menu');
  }

  // =========================================================
  // NOTIFICATIONS
  // =========================================================

  void openNotifications(
    BuildContext context,
  ) {
    debugPrint('Open notifications');
  }

  // =========================================================
  // ORDER
  // =========================================================

  void openOrder(
    BuildContext context,
    OrderModel order,
  ) {
    debugPrint(
      'Open order: ${order.id}',
    );

    // Later navigate based on status.
    //
    // onTheWay -> OnTheWayScreen
    // delivered -> TripCompletedScreen
    // cancelled -> CancelledTripDetailsScreen
  }
}