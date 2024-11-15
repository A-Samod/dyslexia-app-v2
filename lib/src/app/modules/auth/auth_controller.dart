import 'package:firebase_auth/firebase_auth.dart';
import '../home/view/home_screen.dart';
import '../login/view/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/const/constants.dart';
import '../register/controller/user_controller.dart';

class AuthController extends GetxController {
  //create instance of Authcontroller
  static AuthController instance = Get.find();
  bool isAuth = false;

  late Rx<User?> user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges()); //app notify when user login, logout

    ever(user, _checkAuth); //listening user
  }

  _checkAuth(User? user) async {
    if (user == null) {
      debugPrint('Need to login');
      isAuth = false;
    } else {
      debugPrint('User logged in');
      isAuth = true;
    }
  }

  void userSignUp(BuildContext context, String userName, String email,
      String password) async {
    final UserController userController = Get.put(UserController());
    try {
      userController.isLoading.value = true;
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userController.addUser(context, userName, email);
      Get.offAll(const LoginScreen());
      userController.isLoading.value = false;
    } catch (err) {
      Get.snackbar(
        'About user',
        'Login message',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        titleText: const Text(
          'Failed!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: const Text(
          'Something went wrong!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void userLogin(BuildContext context, String email, password) async {
    final UserController userController = Get.put(UserController());
    try {
      userController.isLoading.value = true;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await userController.getUserId(context, email);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userController.userName.value = prefs.getString(USER_NAME) ?? '';
      userController.email.value = prefs.getString(EMAIL) ?? '';
      userController.uuid.value = prefs.getString(UUID) ?? '';
      userController.isLoading.value = false;

      Get.snackbar(
        'About user',
        'Login message',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[400],
        titleText: const Text(
          'Success!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: const Text(
          'Login successful!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
      Get.offAll(const HomeScreen());
    } catch (err) {
      Get.snackbar(
        'About user',
        'Login message',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[700],
        titleText: const Text(
          'Login Failed!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          err.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void userLogout() async {
    await auth.signOut();
    await Future(
      () {
        Get.snackbar(
          'About user',
          'Logout message',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[400],
          titleText: const Text(
            'Success!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          messageText: const Text(
            'Logged out successfully!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
    Get.offAll(const LoginScreen());
  }
}
