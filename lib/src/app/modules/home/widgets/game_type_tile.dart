import 'package:flutter/material.dart';

class GameTypeTile extends StatelessWidget {
  const GameTypeTile({
    super.key,
    required this.title,
    required this.onTapFunc,
  });

  final String title;
  final Function onTapFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () => onTapFunc(),
      ),
    );
  }
}
