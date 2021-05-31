import 'package:flutter/material.dart';

class TotalCard extends StatelessWidget {
  final String total;
  final String title;

  const TotalCard({Key key, this.total, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'ريال',
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor),
              ),
              SizedBox(width: 10),
              Text(
                total,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
