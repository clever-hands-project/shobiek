import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Color color;
  final double size;
  final IconData icon;
  final Function onTap;
  final Color iconColor;

  const CustomIconButton(
      {Key key,
      @required this.icon,
      this.size,
      this.onTap,
      this.color,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 25,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.all(5),
            )),
        child: FittedBox(
          child: Icon(
            icon,
            color: iconColor ?? Colors.black54,
          ),
        ),
        // color: color ?? Colors.white,
        onPressed: onTap ?? () {},
      ),
    );
  }
}
