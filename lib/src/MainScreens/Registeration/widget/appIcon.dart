import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final double height;

  const AppIcon({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Center(
          child: Image.asset('assets/icon/Clever Hands (1).png',

              height: 300 ?? 100, fit: BoxFit.cover)),
    );
  }
}
