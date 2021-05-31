import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/profile.dart';
import 'package:shobek/src/MainScreens/HomeScreen/notifications/notifications.dart';
import 'package:shobek/src/MainScreens/shop/shopHomeScreen.dart';
import 'package:shobek/src/MainWidgets/app_bottom_bar.dart';

class ShopMainPage extends StatefulWidget {
  @override
  _ShopMainPageState createState() => _ShopMainPageState();
}

class _ShopMainPageState extends State<ShopMainPage>
    with SingleTickerProviderStateMixin {
  var _bottomNavIndex = 1;

  List<Widget> widgets = [
    NotificationsScreen(),
    ShopHomeScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widgets[_bottomNavIndex],
      bottomNavigationBar: AppBottomBar(
        userType: "shop",
        onTap: (v) {
          setState(() {
            _bottomNavIndex = v;
          });
        },
      ),
    );
  }
}
