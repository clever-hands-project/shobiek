import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final double height;

  const AppIcon({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
      child: Center(
          child: Image.asset('assets/icon/logo.png',
              height: 100 ?? 100, fit: BoxFit.cover)),
    );
  }
}
