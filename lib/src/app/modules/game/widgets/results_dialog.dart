import 'package:flutter/material.dart';

import '../../../widgets/icon_button_widget.dart';
import '../../../widgets/primary_button_widget.dart';
import 'results_row.dart';

void showResultsDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    // barrierDismissible: true,
    // barrierLabel: "Dismiss",
    pageBuilder: (context, _, __) {
      return Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/resultScreenBG.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'සම්පූර්ණයි',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              PrimaryButtonWidget(
                title: 'ඉදිරියට යන්න',
                onPressedFunc: () {},
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 250,
                child: Column(
                  children: [
                    ResultsRow(
                      title: 'වැරදි ගණන',
                      result: '5',
                    ),
                    SizedBox(height: 5),
                    ResultsRow(
                      title: 'වාර ගණන',
                      result: '3',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //-----Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButtonWidget(icon: Icons.home, onPressedFunc: () {}),
                  const SizedBox(width: 50),
                  IconButtonWidget(icon: Icons.refresh, onPressedFunc: () {}),
                ],
              )
            ],
          ),
        ),
      ));
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
