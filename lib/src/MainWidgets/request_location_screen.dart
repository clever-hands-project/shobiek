import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../MainScreens/Intro/splash_screen.dart';

class RequestLocationScreen extends StatefulWidget {
  @override
  _RequestLocationScreenState createState() => _RequestLocationScreenState();
}

class _RequestLocationScreenState extends State<RequestLocationScreen> {
  @override
  void initState() {
    Geolocator.openLocationSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'من فضلك قم بتشغيل خدمة تحديد الموقع',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: buildButton(
              mediaQuery: mediaQuery,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Splash()),
                    (Route<dynamic> route) => false);
              },
              buttonTitle: 'اعد التشغيل',
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildButton({
  @required MediaQueryData mediaQuery,
  @required Color color,
  @required Function onPressed,
  @required String buttonTitle,
  @required Color textColor,
}) {
  return Container(
    width: mediaQuery.size.width * 0.4,
    child: ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(6),
          backgroundColor: MaterialStateProperty.all(color)),
      onPressed: onPressed,
      child: Text(
        buttonTitle,
        style: TextStyle(color: textColor),
      ),
    ),
  );
}
