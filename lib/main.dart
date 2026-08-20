import 'package:client_app/core/theme/app_theme.dart';
import 'package:client_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/splash/view/splash_screen.dart';
import 'features/splash/viewmodel/splash_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint('🔥 Firebase initialized successfully');

  runApp(
    const PatgolitoApp(),
  );
}

class PatgolitoApp extends StatelessWidget {
  const PatgolitoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SplashViewModel>(
          create: (_) => SplashViewModel(),
        ),

        // ChangeNotifierProvider<OtpViewModel>(
        //   create: (_) => OtpViewModel(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Patgolito',
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}