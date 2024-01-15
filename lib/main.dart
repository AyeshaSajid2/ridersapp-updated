import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ridersapp/authentication/auth_screen.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:ridersapp/firebase_options.dart';
import 'package:ridersapp/global/global.dart';
import 'package:ridersapp/splash_screen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodFlow',
      theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          ),
      routes: {
        '/auth': (context) => const AuthScreen(),
        // Other routes if needed
      },
      home: const MySplashScreen(),
    );
  }
}
