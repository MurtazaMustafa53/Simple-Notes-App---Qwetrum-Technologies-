import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final double size;
  const Custombutton({
    super.key,
    required this.onTap,
    required this.title,
    this.size = 30,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightGreenAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(),
      ),
      child: Text(title, style: TextStyle(fontSize: size)),
    );
  }
}
