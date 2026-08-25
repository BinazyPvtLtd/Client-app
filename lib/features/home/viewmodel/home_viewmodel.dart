
import 'package:client_app/features/location/view/select_location_screen.dart';
import 'package:client_app/features/notifications/view/notification_screen.dart';
import 'package:flutter/material.dart';
import '../model/home_service_model.dart';
import '../model/recent_booking_model.dart';
import '../model/vehicle_model.dart';

class HomeViewModel extends ChangeNotifier {


String get recentDropLocation =>
    'Gomti Nagar, Lucknow';

    void onRecentDropPressed(
  BuildContext context,
) {
  debugPrint(
    'Recent drop selected: $recentDropLocation',
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const SelectLocationScreen(),
    ),
  );
}

    
  // =========================================================
  // SERVICES
  // =========================================================

  final List<HomeServiceModel> services = const [
    HomeServiceModel(
      title: 'Truck',
      description: 'Move your goods',
      icon: Icons.local_shipping_rounded,
    ),
    HomeServiceModel(
      title: '2 Wheeler',
      description: 'Send small packages',
      icon: Icons.two_wheeler_rounded,
    ),
    HomeServiceModel(
      title: 'Mini Truck',
      description: 'Quick city transport',
      icon: Icons.airport_shuttle_rounded,
    ),
    HomeServiceModel(
      title: 'Packers & Movers',
      description: 'Need help moving?',
      icon: Icons.inventory_2_outlined,
    ),
  ];

  // =========================================================
  // VEHICLES
  // =========================================================

  final List<VehicleModel> vehicles = const [
    VehicleModel(
      title: '2 Wheeler',
      icon: Icons.two_wheeler_rounded,
    ),
    VehicleModel(
      title: 'Mini Truck',
      icon: Icons.airport_shuttle_rounded,
    ),
    VehicleModel(
      title: '3 Wheeler',
      icon: Icons.electric_rickshaw_rounded,
    ),
    VehicleModel(
      title: 'Truck',
      icon: Icons.local_shipping_rounded,
    ),
  ];

  // =========================================================
  // RECENT BOOKINGS
  // =========================================================

  final List<RecentBookingModel> recentBookings = const [
    RecentBookingModel(
      vehicleName: '2 Wheeler',
      time: 'Today, 3:25 PM',
      pickup: 'Aliganj',
      destination: 'Gomti Nagar',
      amount: '₹147',
      status: 'Completed',
      icon: Icons.two_wheeler_rounded,
    ),
  ];

  // =========================================================
  // SERVICE ACTION
  // =========================================================

  void onServiceSelected(
    BuildContext context,
    String service,
  ) {
    debugPrint('Selected service: $service');

    switch (service) {
      case 'Truck':
      case 'Trucks':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SelectLocationScreen(),
          ),
        );
        break;

      case '2 Wheeler':
      case '2 Wheelers':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SelectLocationScreen(),
          ),
        );
        debugPrint('2 Wheeler selected');
        break;

      case 'Mini Truck':
      case 'Mini Trucks':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SelectLocationScreen(),
          ),
        );
        debugPrint('Mini Truck selected');
        break;

      case 'Packers & Movers':
        debugPrint('Packers & Movers selected');
        break;

      default:
        debugPrint(
          'No navigation configured for: $service',
        );
    }
  }

  

  // =========================================================
  // VEHICLE ACTION
  // =========================================================

  void onVehiclePressed(
    BuildContext context,
    VehicleModel vehicle,
  ) {
    debugPrint(
      'Selected vehicle: ${vehicle.title}',
    );

    onServiceSelected(
      context,
      vehicle.title,
    );
  }


  

  // =========================================================
  // LOCATION
  // =========================================================

  void onLocationPressed() {
    debugPrint('Location pressed');
  }

  // =========================================================
  // NOTIFICATIONS
  // =========================================================

  void onNotificationPressed(
  BuildContext context,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const NotificationScreen(),
    ),
  );
}
  // =========================================================
  // PROFILE
  // =========================================================

  void onProfilePressed() {
    debugPrint('Profile pressed');
  }

  // =========================================================
  // BOOKINGS
  // =========================================================

  void onViewAllBookings() {
    debugPrint('View all bookings');
  }
}