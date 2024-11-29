import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/const/colors.dart';
import '../../../../core/const/constants.dart';
import '../../../widgets/turn_landscape_alert.dart';
import '../../register/controller/user_controller.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/game_type_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.put(UserController());

  //get email and password that stored in shared preferences
  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userController.isLoading.value = true;
    userController.email.value = prefs.getString(EMAIL) ?? '';
    userController.userName.value = prefs.getString(USER_NAME) ?? '';
    userController.uuid.value = prefs.getString(UUID) ?? '';
    debugPrint('#####');
    debugPrint(prefs.getString(EMAIL));
    debugPrint(prefs.getString(USER_NAME));
    debugPrint('#####');

    userController.isLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
    getUser();

    //---- show screen for portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => userController.isLoading.value == true
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: PRIMARY_COLOR,
                          backgroundColor: Colors.black12,
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/selectScreenBG.jpeg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 40,
                                ),
                                child: Column(
                                  children: [
                                    GameTypeTile(
                                      title: 'තනි අකුරු ලියමු',
                                      onTapFunc: () {
                                        showOrientationAlert(
                                          context,
                                          'single',
                                          '/writing-screen',
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 25),
                                    GameTypeTile(
                                      title: 'අකුරු දෙකේ වචන ලියමු',
                                      onTapFunc: () {
                                        showOrientationAlert(
                                          context,
                                          'two',
                                          '/writing-screen',
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 25),
                                    GameTypeTile(
                                      title: 'අකුරු තුනේ වචන ලියමු',
                                      onTapFunc: () {
                                        showOrientationAlert(
                                          context,
                                          'three',
                                          '/writing-screen',
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Positioned(
            top: 0,
            left: 20,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/profilepic.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              elevation: 0, // Removes the shadow
            ),
          ),
        ],
      ),
      drawer: DrawerMenu(
        userName: userController.userName.toString(),
        userEmail: userController.email.toString(),
      ),
    );
  }
}
