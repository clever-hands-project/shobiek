import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';

class Filtter extends StatelessWidget {
  final String title;
  final Function onTap;
  final Color backgroundColor;
  final Color titleColor;
  final double elevation;

  const Filtter({
    Key key,
    this.title,
    this.onTap,
    this.backgroundColor,
    this.titleColor,
    this.elevation,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomBtn(
      onTap: onTap,
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      text: title,
      fontSize: 14,
      elevation: elevation ?? 0,
      txtColor: titleColor ?? Colors.black87,
      fontWeight: FontWeight.bold,
    );
  }
}
