import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomOptionCard {
  Widget optionCard(
      {String label,
      String content,
      final icon,
      Function onTap,
      Color bgColor,
      BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(top: 5, right: 10, left: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: bgColor ?? Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content ?? "",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black87, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      label,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.black87, fontSize: 17),
                    ),
                  ),
                  Visibility(
                    visible: icon != null,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Image.asset(icon),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget optionCard2({String txt, IconData icon, Function onTap, Color color}) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 47,
            child: ListTile(
              leading: Icon(icon),
              title: Text(
                txt,
                style: TextStyle(
                    color: color == null ? Colors.black : color, fontSize: 17),
              ),
              trailing: Directionality(
                textDirection: localization.currentLanguage.toString() == "en"
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: color == null ? Colors.grey : color,
                  size: 20,
                ),
              ),
              onTap: onTap,
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
