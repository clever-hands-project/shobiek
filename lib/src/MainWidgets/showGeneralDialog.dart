import 'package:flutter/material.dart';

class GeneraDialog {
  show(BuildContext context, Widget child) {
    bool _fromTop = true;
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: _fromTop ? Alignment.topCenter : Alignment.bottomCenter,
          child: child,
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
            position:Tween(begin: Offset(0, _fromTop ? -1 : 1), end: Offset(0, 0.2)).animate(anim1),
            child: child);
      },
    );
  }
}
