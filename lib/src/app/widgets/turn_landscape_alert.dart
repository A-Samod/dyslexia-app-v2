import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/const/colors.dart';

void showOrientationAlert(
  BuildContext context,
  String gameMode,
  String route,
) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents closing by tapping outside
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/orientation_alert.json',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
              repeat: true,
            ),
            const SizedBox(height: 20),
            const Text(
              'Please rotate your device',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Turn your phone to landscape mode to continue.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              debugPrint(gameMode);
              Navigator.of(context).pop();
              Navigator.pushNamed(context, route, arguments: gameMode);
            },
            child: const Text(
              'OK',
              style: TextStyle(color: PRIMARY_COLOR),
            ),
          ),
        ],
      );
    },
  );
}
