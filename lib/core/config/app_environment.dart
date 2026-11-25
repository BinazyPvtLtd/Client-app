// import 'package:flutter/foundation.dart';

// class AppEnvironment {
//   AppEnvironment._();

//   static const bool useMockApi = bool.fromEnvironment(
//     'USE_MOCK_API',
//     defaultValue: true,
//   );

//   static bool get isMockMode => kDebugMode && useMockApi;
// }


import 'package:flutter/foundation.dart';

class AppEnvironment {
  AppEnvironment._();

  // false = Real Laravel API
  // true  = Mock API

  static const bool useMockApi = bool.fromEnvironment(
    'USE_MOCK_API',
    defaultValue: false,
  );

  static bool get isMockMode => kDebugMode && useMockApi;
}