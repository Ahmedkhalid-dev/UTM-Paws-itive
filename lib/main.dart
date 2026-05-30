import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/report_animal_screen.dart';
import 'screens/report_success_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/user_profile_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const PawsitiveApp());

class PawsitiveApp extends StatelessWidget {
  const PawsitiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTM Paws-itive',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const UserProfileScreen(),
        '/report': (context) => const ReportAnimalScreen(),
        '/success': (context) => const ReportSuccessScreen(),
      },
    );
  }
}
