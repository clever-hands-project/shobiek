import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomButtonClock extends StatelessWidget {
  final icon;
  final String lable;
  final date;
  final Function onConfirm;
  final onTap;

  const CustomButtonClock(
      {Key key, this.icon, this.date, this.onTap, this.lable, this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DatePicker.showTimePicker(context,
            currentTime: DateTime.now(),
            locale: LocaleType.ar,
            onConfirm: onConfirm);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.grey),
            ),
            width: MediaQuery.of(context).size.width - 70,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.grey,
                    size: 20,
                  ),
                  Expanded(
                    child: Text(
                      date,
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(lable)
        ],
      ),
    );
  }
}
