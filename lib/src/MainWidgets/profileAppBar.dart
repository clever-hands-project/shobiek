import 'package:flutter/material.dart';

import 'defaultAppbar.dart';

class ProfileAppBar extends StatelessWidget {
  final String title;
  final String name;
  final String location;
  final bool hasBack;
  final Function onBack;
  final Widget image;
  final Widget icon;

  const ProfileAppBar(
      {Key key,
      this.title,
      this.name,
      this.location,
      this.hasBack,
      this.onBack,
      this.image,
      this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          defaultAppBar(
            context: context,
            title: title ?? "title",
            elevation: 0.0,
            hasBack: hasBack ?? false,
            onPress: onBack ?? () {},
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
              child: image,
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Stack(
              //       children: <Widget>[
              //         // Image
              //         image,
              //         //  Icon
              //         Positioned(
              //           bottom: 0,
              //           right: 4,
              //           child: icon ?? SizedBox(),
              //         ),
              //       ],
              //     )
              //   ],
              // ),
            ),
          ),
          // Name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          // Location
          location != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    location,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(height: 5),
          Container(
            height: 6,
            width: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
