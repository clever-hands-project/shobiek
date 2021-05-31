import 'package:flutter/material.dart';

class LockIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
      child: Center(
          child: Image.asset('assets/icon/padlock.png',
              height: 60, fit: BoxFit.cover)),
    );
  }
}
