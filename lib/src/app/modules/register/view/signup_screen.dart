import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/const/colors.dart';
import '../../../widgets/my_form_field.dart';
import '../../auth/auth_controller.dart';
import '../controller/user_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final UserController userController = Get.put(UserController());
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => userController.isLoading.value == true
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/loadingAnimation.json',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                    repeat: true,
                  ),
                  // CircularProgressIndicator(
                  //   color: PRIMARY_COLOR,
                  //   backgroundColor: Colors.black12,
                  // ),
                ],
              ), // Show loading indicator
            )
          : Center(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                          scale: 0.8,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Form(
                            key: _formKey,
                            autovalidateMode: _autoValidate,
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    //User Name Field
                                    MyFormField(
                                      enable: true,
                                      autofocus: false,
                                      isObscureText: false,
                                      hint: "Enter user name here",
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Please enter your user name';
                                        }
                                        return null;
                                      },
                                      icon: Icon(
                                        Icons.person,
                                        color: Colors.grey[500],
                                      ),
                                      controller: userNameController,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),

                                    //Email Field
                                    MyFormField(
                                      enable: true,
                                      autofocus: false,
                                      isObscureText: false,
                                      hint: "Enter email here",
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        return null;
                                      },
                                      icon: Icon(
                                        Icons.email,
                                        color: Colors.grey[500],
                                      ),
                                      controller: emailController,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),

                                    //Password Field
                                    MyFormField(
                                      enable: true,
                                      autofocus: false,
                                      isObscureText: true,
                                      hint: "Enter password here",
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                      icon: Icon(
                                        Icons.password,
                                        color: Colors.grey[500],
                                      ),
                                      controller: pwdController,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),

                                //Sign in button
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        handleSignUp();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                SECONDARY_COLOR2),
                                      ),
                                      child: const Text(
                                        'Create account',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                //Register button
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.white),
                                      ),
                                      child: const Text(
                                        'Sign in',
                                        style: TextStyle(
                                          color: SECONDARY_COLOR1,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ),
    ));
  }

  handleSignUp() async {
    String userNameHandler = userNameController.text;
    String emailHandler = emailController.text;
    String passwordHandler = pwdController.text;

    if (_formKey.currentState!.validate()) {
      userController.isLoading.value = true;
      await Future(() {
        AuthController.instance.userSignUp(
          context,
          userNameHandler,
          emailHandler,
          passwordHandler,
        );
      });
      userController.isLoading.value = false;
    } else {
      setState(() => _autoValidate = AutovalidateMode.always);
    }
  }
}
