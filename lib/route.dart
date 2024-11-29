import 'package:flutter/material.dart';

import 'src/app/modules/Splash/splash_screen.dart';
import 'src/app/modules/dashboard/view/dashboard_screen.dart';
import 'src/app/modules/game/view/writing_screen.dart';
import 'src/app/modules/home/view/home_screen.dart';
import 'src/app/modules/login/view/login.dart';
import 'src/app/modules/profie/view/profile_screen.dart';
import 'src/app/modules/register/view/signup_screen.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/writing-screen':
        final gameMode = args as String;
        return MaterialPageRoute(
          builder: (_) => WritingScreen(
            gameMode: gameMode,
          ),
        );
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
