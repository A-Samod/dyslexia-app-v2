import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.icon,
    required this.onPressedFunc,
  });

  final IconData icon;
  final VoidCallback onPressedFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        color: Colors.black,
        onPressed: onPressedFunc,
        icon: Icon(icon),
      ),
    );
  }
}
