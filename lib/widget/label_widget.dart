import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LabelWidget extends StatelessWidget {
  String name;
  Color backgroundColor;
  Color? foregroundColor;
  EdgeInsetsGeometry? padding;
  BorderRadius? borderRadius;
  IconData? icon;

  LabelWidget(this.name, this.backgroundColor,
      {Color? foregroundColor,
      BorderRadius? borderRadius,
      EdgeInsetsGeometry? padding,
      this.icon})
      : foregroundColor = foregroundColor ?? Colors.black,
        borderRadius = borderRadius ?? BorderRadius.circular(12.0),
        padding =
            padding ?? const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor,
      ),
      padding: padding,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Icon(
                  icon,
                  color: foregroundColor,
                  size: 12.0,
                ),
              ),
            Text(
              name,
              style: TextStyle(color: foregroundColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
