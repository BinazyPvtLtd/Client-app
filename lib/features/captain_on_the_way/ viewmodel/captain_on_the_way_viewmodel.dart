// import 'package:flutter/material.dart';

// class CaptainOnTheWayViewModel
//     extends ChangeNotifier {
//   // =========================================================
//   // DRIVER
//   // =========================================================

//   String get driverName =>
//       'Rahul Kumar';

//   String get driverRating =>
//       '4.8';

//   String get vehicleNumber =>
//       'UP32 AB 1234';

//   // =========================================================
//   // DUMMY PERMANENT USER OTP
//   // Later fetch this from backend/user profile.
//   // =========================================================

//   String get rideOtp =>
//       '4827';

//   // =========================================================
//   // ETA
//   // =========================================================

//   int get arrivalMinutes => 6;

//   String get arrivalText =>
//       'Arriving in $arrivalMinutes min';

//   // =========================================================
//   // CALL
//   // =========================================================

//   void callDriver() {
//     debugPrint(
//       'Call driver',
//     );
//   }

//   // =========================================================
//   // CHAT
//   // =========================================================

//   void openChat(
//     BuildContext context,
//   ) {
//     debugPrint(
//       'Open chat',
//     );
//   }

//   // =========================================================
//   // INFO
//   // =========================================================

//   void openInfo(
//     BuildContext context,
//   ) {
//     showDialog(
//       context: context,

//       builder: (
//         dialogContext,
//       ) {
//         return AlertDialog(
//           title: const Text(
//             'Captain is on the way',
//           ),

//           content: Text(
//             '$driverName has accepted your booking and is heading toward your pickup location.',
//           ),

//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(
//                   dialogContext,
//                 );
//               },

//               child:
//                   const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // =========================================================
//   // CANCEL
//   // =========================================================

//   void cancelRide(
//     BuildContext context,
//   ) {
//     debugPrint(
//       'Cancel ride',
//     );

//     Navigator.pop(context);
//   }
// }


import 'package:flutter/material.dart';

// ============================================================
// RIDE STATUS
// ============================================================

enum CaptainRideStatus {
  onTheWay,
  arrived,
}

class CaptainOnTheWayViewModel extends ChangeNotifier {
  // ==========================================================
  // STATUS
  // ==========================================================

  CaptainRideStatus _status =
      CaptainRideStatus.onTheWay;

  CaptainRideStatus get status => _status;

  bool get hasCaptainArrived =>
      _status == CaptainRideStatus.arrived;

  // ==========================================================
  // DRIVER
  // ==========================================================

  String get driverName => 'Rahul Kumar';

  String get driverRating => '4.8';

  String get vehicleName => '2 Wheeler';

  String get vehicleNumber => 'UP32 AB 1234';

  // ==========================================================
  // OTP
  //
  // Dummy permanent OTP for now.
  // Later backend will return this user's OTP.
  // ==========================================================

  String get rideOtp => '4827';

  // ==========================================================
  // ETA
  // ==========================================================

  int _arrivalMinutes = 6;

  int get arrivalMinutes => _arrivalMinutes;

  String get arrivalText {
    if (hasCaptainArrived) {
      return 'Captain has arrived';
    }

    return 'Arriving in $_arrivalMinutes min';
  }

  // ==========================================================
  // TEST DRIVER ARRIVAL
  //
  // Later this method will be called when backend/socket
  // sends driver-arrived event.
  // ==========================================================

  void setDriverArrived() {
    if (hasCaptainArrived) {
      return;
    }

    _status = CaptainRideStatus.arrived;

    notifyListeners();
  }

  // ==========================================================
  // DRIVER LOCATION UPDATE
  //
  // Later:
  // update lat/lng from socket here.
  // ==========================================================

  void updateArrivalMinutes(
    int minutes,
  ) {
    _arrivalMinutes = minutes;

    notifyListeners();
  }

  // ==========================================================
  // CALL
  // ==========================================================

  void callDriver() {
    debugPrint('Call driver');
  }

  // ==========================================================
  // CHAT
  // ==========================================================

  void openChat(
    BuildContext context,
  ) {
    debugPrint('Open driver chat');
  }

  // ==========================================================
  // INFO
  // ==========================================================

  void openInfo(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (
        dialogContext,
      ) {
        return AlertDialog(
          title: Text(
            hasCaptainArrived
                ? 'Captain has arrived'
                : 'Captain is on the way',
          ),
          content: Text(
            hasCaptainArrived
                ? '$driverName has reached your pickup location.'
                : '$driverName is heading towards your pickup location.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // CANCEL
  // ==========================================================

  void cancelRide(
    BuildContext context,
  ) {
    debugPrint('Cancel ride');

    Navigator.pop(context);
  }
}