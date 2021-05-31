import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/driver/driverHomeScreen.dart';
import 'package:shobek/src/MainScreens/shop/shopHomeScreen.dart';
import 'package:shobek/src/MainScreens/HomeScreen/userHomeScreen.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/profile.dart';
import 'package:shobek/src/MainScreens/HomeScreen/cart/cart.dart';
import 'package:shobek/src/MainScreens/HomeScreen/notifications/notifications.dart';
import 'package:shobek/src/MainScreens/HomeScreen/orders/orders.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.userType, this.tabItem, this.onBack});
  final GlobalKey<NavigatorState> navigatorKey;
  final int tabItem;
  final String userType;
  final Function onBack;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (userType == 'user') {
      switch (tabItem) {
        case 0:
          child = NotificationsScreen(onBack: onBack);
          break;
        case 1:
          child = CartScreen(onBack: onBack);
          break;
        case 2:
          child = UserHomeScreen();
          break;
        case 3:
          child = OrderScreen(onBack: onBack);
          break;
        case 4:
          child = ProfileScreen(onBack: onBack);
          break;
        default:
          child = UserHomeScreen();
      }
    } else {
      switch (tabItem) {
        case 0:
          child = NotificationsScreen(onBack: onBack);
          break;
        case 1:
          if (userType == 'shop') {
            child = ShopHomeScreen();
          } else if (userType == 'driver') {
            child = DriverHomeScreen();
          }
          break;
        case 2:
          child = ProfileScreen(onBack: onBack);
          break;
        default:
          if (userType == 'shop') {
            child = ShopHomeScreen();
          } else if (userType == 'driver') {
            child = DriverHomeScreen();
          }
      }
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
