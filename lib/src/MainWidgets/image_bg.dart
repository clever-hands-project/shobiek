import 'package:flutter/material.dart';

class ImageBG extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/bg.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
