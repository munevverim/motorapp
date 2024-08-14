import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teto/views/chat_screen.dart';
import 'package:teto/views/edit_profile_screen.dart';
import 'package:teto/views/map_screen.dart';
import 'package:teto/views/register_screen.dart';
import 'views/home_screen.dart';
import 'views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motorcycle Ride Sharing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          backgroundColor: Color(0xFFF5F5F5), // Light Grey
        ).copyWith(
          secondary: Color(0xFFFFA000), // Amber for accent color
          error: Color(0xFFD32F2F), // Red for error color
          onPrimary: Colors.white, // Text color on primary color
          onSecondary: Colors.white, // Text color on secondary color
        ),
        scaffoldBackgroundColor: Color(0xFFFFFFFF), // White
        textTheme: TextTheme(
          headlineLarge: TextStyle(color: Color(0xFF212121)), // Dark Grey
          bodyLarge: TextStyle(color: Color(0xFF212121)), // Dark Grey
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1976D2), // Blue
          iconTheme: IconThemeData(color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF1976D2), // Blue
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFA000), // Amber
        ),
      ),
      home:ChatScreen (),
    );
  }
}
