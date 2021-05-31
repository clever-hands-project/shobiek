import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppEmpty extends StatefulWidget {
  final String text;

  const AppEmpty({Key key, this.text}) : super(key: key);

  @override
  _AppEmptyState createState() => _AppEmptyState();
}

class _AppEmptyState extends State<AppEmpty> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Lottie.asset(
          'assets/lolitJson/empty.json',
          height: 200,
          width: 200,
        )),
        SizedBox(height: 20),
        Text(widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, color: Colors.grey))
      ],
    );
  }
}
