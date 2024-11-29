import 'package:flutter/material.dart';

import '../../../../core/const/colors.dart';
import '../../auth/auth_controller.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  final String userName;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: PRIMARY_COLOR,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
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
                    const SizedBox(width: 20),
                    // User name
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(userEmail, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: PRIMARY_COLOR,
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   child: ListTile(
                  //     title: const Text(
                  //       "Profile",
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //     onTap: () {
                  //       Navigator.pushNamed(context, '/profile');
                  //     },
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: const Text(
                        "ප්‍රගති පුවරුව",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/dashboard');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ListTile at the bottom
          Padding(
            padding:
                const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const ListTile(
                  title: Text(
                    "Logout",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // onTap: () {
                  //   Navigator.pop(context);
                  // },
                ),
              ),
              onTap: () {
                AuthController.instance.userLogout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
