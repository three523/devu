import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String title;
  final Color? backgroundColor;

  const Label({super.key, required this.title, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        minimumSize: Size.zero,
      ),
      // color: backgroundColor ?? Colors.grey,
      child: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
