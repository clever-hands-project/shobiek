import 'dart:async';
import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/networkImage.dart';
import 'package:shobek/src/MainWidgets/profileAppBar.dart';
import 'package:shobek/src/Models/auth/AuthModle.dart';
import 'package:shobek/src/Provider/DriverProvider/availabiltyProvider.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:shobek/src/Provider/DriverProvider/availableTimerProvider.dart';

import 'driverCommitions.dart';
import 'driverOrders.dart';

class DriverHomeScreen extends StatefulWidget {
  @override
  _DriverHomeScreenState createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  bool isActive = false;
  Timer timer;

  @override
  void initState() {
    isActive = Provider.of<AuthController>(context, listen: false)
        .userModel
        .data
        .available;
    timer = Timer.periodic(Duration(minutes: 5), (Timer t) {
      if (Provider.of<AuthController>(context, listen: false)
              .userModel
              .data
              .available ==
          true) {
        Provider.of<AvilableTimerProvider>(context, listen: false)
            .changeAvailable(
          available: 1,
          context: context,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserData user =
        Provider.of<AuthController>(context, listen: true).userModel.data;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileAppBar(
              title: "الرئيسية",
              name: "${user.name}",
              image: CircleAvatar(
                radius: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: networkImage(user.photo),
                ),
              ),
              icon: Badge(
                toAnimate: false,
                shape: BadgeShape.circle,
                badgeColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                padding: EdgeInsets.all(2),
                badgeContent: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ToggleSwitch(
              minHeight: 30,
              cornerRadius: 10.0,
              activeBgColor: Theme.of(context).primaryColor,
              activeFgColor: Colors.black,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              labels: ['متاح', 'غير متاح'],
              initialLabelIndex: isActive ? 0 : 1,
              changeOnTap: true,
              onToggle: (index) {
                setState(() {
                  if (index == 0) {
                    Provider.of<AvailabilityProvider>(context, listen: false)
                        .changeAvailable(
                      available: 1,
                      context: context,
                    )
                        .then((v) async {
                      Provider.of<AuthController>(context, listen: false)
                          .userModel
                          .data
                          .available = true;
                      await Provider.of<AuthController>(context, listen: false)
                          .storageUserData(json.encode(
                              Provider.of<AuthController>(context,
                                      listen: false)
                                  .userModel));
                    });
                    isActive = true;
                  } else if (index == 1) {
                    Provider.of<AvailabilityProvider>(context, listen: false)
                        .changeAvailable(
                      available: 0,
                      context: context,
                    )
                        .then((v) async {
                      Provider.of<AuthController>(context, listen: false)
                          .userModel
                          .data
                          .available = false;
                      await Provider.of<AuthController>(context, listen: false)
                          .storageUserData(json.encode(
                              Provider.of<AuthController>(context,
                                      listen: false)
                                  .userModel));
                    });
                    isActive = false;
                  }
                });
                print(isActive);
              },
            ),
            SizedBox(height: 40),
            CustomBtn(
              heigh: 60,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              txtColor: Theme.of(context).accentColor,
              text: "طلباتي الجديدة",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DriverOrders(
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                );
              },
            ),
            CustomBtn(
              heigh: 60,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
              txtColor: Colors.white,
              text: "عمولاتي",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => Commitions(
                              url: "driver-commission",
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
