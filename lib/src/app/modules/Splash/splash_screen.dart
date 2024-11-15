import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../auth/auth_controller.dart';
import '../home/view/home_screen.dart';
import '../login/view/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/SplashScreenBG.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Lottie.asset(
            'assets/animations/loadingAnimation.json',
            width: 150,
            height: 150,
            fit: BoxFit.contain,
            repeat: true,
          ),
        ]),
      ),
    );
  }

  Future checkAuth() async {
    await Future.delayed(
      const Duration(milliseconds: 2500),
    );

    Get.offAll(const LoginScreen());
    if (_authController.isAuth == true) {
      Get.offAll(const HomeScreen());
    } else {
      Get.offAll(const LoginScreen());
    }
  }
}
