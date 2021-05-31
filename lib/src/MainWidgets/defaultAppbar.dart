import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/Registeration/widget/backBtn.dart';

Widget defaultAppBar({
  @required BuildContext context,
  @required String title,
  Function onPress,
  bool hasBack = false,
  double elevation,
  Widget icon,
  List<Widget> actions,
}) {
  return AppBar(
    elevation: elevation ?? 4,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    centerTitle: true,
    actions: actions ?? [],
    leading: hasBack
        ? BackBtn(
            color: Colors.white,
            onPress: onPress,
          )
        : icon ?? SizedBox(),
    backgroundColor: Theme.of(context).accentColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    ),
  );
}
