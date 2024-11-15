import 'package:flutter/material.dart';

import '../../core/const/colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget({
    super.key,
    required this.title,
    required this.onPressedFunc,
  });

  final String title;
  final VoidCallback onPressedFunc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedFunc,
      style: ElevatedButton.styleFrom(
        backgroundColor: PRIMARY_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
