import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color;
  final Color txtColor;
  final double heigh, fontSize;
  final double elevation;
  final FontWeight fontWeight;

  const CustomBtn(
      {Key key,
      @required this.text,
      @required this.onTap,
      @required this.color,
      this.txtColor,
      this.heigh,
      this.elevation,
      this.fontSize,
      this.fontWeight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: MaterialButton(
        onPressed: onTap,
        color: color,
        height: heigh,
        elevation: elevation ?? 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: txtColor,
              fontSize: fontSize ?? 14,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
