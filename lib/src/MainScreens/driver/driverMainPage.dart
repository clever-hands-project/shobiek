import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/profile.dart';
import 'package:shobek/src/MainScreens/driver/driverHomeScreen.dart';
import 'package:shobek/src/MainScreens/HomeScreen/notifications/notifications.dart';
import 'package:shobek/src/MainWidgets/app_bottom_bar.dart';

class DriverMainPage extends StatefulWidget {
  @override
  _DriverMainPageState createState() => _DriverMainPageState();
}

class _DriverMainPageState extends State<DriverMainPage>
    with SingleTickerProviderStateMixin {
  var _bottomNavIndex = 1;

  List<Widget> widgets = [
    NotificationsScreen(),
    DriverHomeScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widgets[_bottomNavIndex],
      bottomNavigationBar: AppBottomBar(
        userType: "driver",
        onTap: (v) {
          setState(() {
            _bottomNavIndex = v;
          });
        },
      ),
    );
  }
}
