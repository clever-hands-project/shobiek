import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CreateSettingRoute {
  Route createSettingsRoute(Widget screen) {
    return PageRouteBuilder<void>(
      transitionDuration: Duration(seconds: 1),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          fillColor: Colors.transparent,
          transitionType: SharedAxisTransitionType.scaled,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
    );
  }
}
