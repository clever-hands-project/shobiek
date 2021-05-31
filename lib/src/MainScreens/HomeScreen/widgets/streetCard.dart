import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/map_helper.dart';

class StreetCard extends StatefulWidget {
  @override
  _StreetCardState createState() => _StreetCardState();
}

class _StreetCardState extends State<StreetCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: 180,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(
          right: 15,
          top: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.red[300],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              Provider.of<MapHelper>(context, listen: false).address ??
                  'شارع محمد علي,المملكة السعودية',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            Provider.of<MapHelper>(context, listen: true).loading
                ? Container(
                    height: 23,
                    width: 23,
                    child: CircularProgressIndicator(
                      value: 1,
                      backgroundColor: Colors.white,
                    ))
                : Icon(
                    Icons.pin_drop_rounded,
                    color: Colors.white,
                    size: 23,
                  )
          ],
        ),
      ),
    );
  }
}
