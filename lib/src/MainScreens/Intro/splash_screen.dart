import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/map_helper.dart';
import 'package:shobek/src/Helpers/route.dart';
import 'package:shobek/src/MainScreens/Chat/chat_room.dart';
import 'package:shobek/src/MainScreens/Intro/waitingScreen.dart';
import 'package:shobek/src/MainScreens/driver/driverMainPage.dart';
import 'package:shobek/src/MainScreens/mainPage.dart';
import 'package:shobek/src/MainScreens/shop/ShopMainPage.dart';
import 'package:shobek/src/MainWidgets/image_bg.dart';
import 'package:shobek/src/Provider/ClientOrderProvider.dart';
import 'package:shobek/src/Provider/DriverProvider/DriverOrderProvider.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Provider/get/getUserDataProvider.dart';
import 'package:shobek/src/Provider/get/setting.dart';
import 'package:shobek/src/Repository/firebaseNotifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Splash extends StatefulWidget {
  final GlobalKey<NavigatorState> navigator;

  const Splash({Key key, this.navigator}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    FirebaseNotifications().setUpFirebase(widget.navigator);

    getData();

    super.initState();
  }

  getData() async {
    await Provider.of<MapHelper>(context, listen: false).getLocation();

    await Provider.of<SettingProvider>(context, listen: false)
        .getUserData(context);
    await Provider.of<GetUserDataProvider>(context, listen: false)
        .getUserData(context);
    await Provider.of<AuthController>(context, listen: false).getStorgeData();
    await Provider.of<GetUserDataProvider>(context, listen: false)
        .getUserData(context);
    if (Provider.of<AuthController>(context, listen: false).userModel != null) {
      int type = Provider.of<AuthController>(context, listen: false).type;
      print("$type");
      if (type == 1) {
        Provider.of<ClientOrdersProvider>(context, listen: false)
            .getClientOrders(1, context)
            .then((value) {
          if (Provider.of<ClientOrdersProvider>(context, listen: false)
                  .clientOrders
                  .length >
              0) {
            pushAndRemoveUntil(
                context,
                ChatRoom(
                  chateId:
                      Provider.of<ClientOrdersProvider>(context, listen: false)
                          .clientOrders[0]
                          .id,
                  phone:
                      Provider.of<ClientOrdersProvider>(context, listen: false)
                          .clientOrders[0]
                          .driverPhone,
                  userName:
                      Provider.of<ClientOrdersProvider>(context, listen: false)
                          .clientOrders[0]
                          .driver,
                  orderPrice:
                      Provider.of<ClientOrdersProvider>(context, listen: false)
                          .clientOrders[0]
                          .orderPrice,
                  price:
                      Provider.of<ClientOrdersProvider>(context, listen: false)
                          .clientOrders[0]
                          .price,
                ));
          } else {
            pushAndRemoveUntil(context, MainPage());
          }
        });
      } else if (type == 2) {
        if (Provider.of<GetUserDataProvider>(context, listen: false)
                .userModel
                .data
                .active ==
            1)
          Provider.of<DriverOrdersProvider>(context, listen: false)
              .getDriverOrders("", "1", context)
              .then((value) {
            if (Provider.of<DriverOrdersProvider>(context, listen: false)
                    .driverOrders
                    .length >
                0) {
              pushAndRemoveUntil(
                  context,
                  ChatRoom(
                    chateId: Provider.of<DriverOrdersProvider>(context,
                            listen: false)
                        .driverOrders[0]
                        .id,
                    phone: Provider.of<DriverOrdersProvider>(context,
                            listen: false)
                        .driverOrders[0]
                        .userPhone,
                    userName: Provider.of<DriverOrdersProvider>(context,
                            listen: false)
                        .driverOrders[0]
                        .user,
                    driverOrder: Provider.of<DriverOrdersProvider>(context,
                            listen: false)
                        .driverOrders[0],
                  ));
            } else {
              pushAndRemoveUntil(context, DriverMainPage());
            }
          });
        else {
          pushAndRemoveUntil(context, WaitingAccepting());
        }
        // pushAndRemoveUntil(context, DriverMainPage());
      } else {
        if (Provider.of<GetUserDataProvider>(context, listen: false)
                .userModel
                .data
                .active ==
            1)
          pushAndRemoveUntil(context, ShopMainPage());
        else {
          pushAndRemoveUntil(context, WaitingAccepting());
        }
      }
    } else {
      pushAndRemoveUntil(context, MainPage());
    }
    //     .then((value) {

    //   } else {
    //     pushAndRemoveUntil(context, MainPage());
    //   }
    // });
  }

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ImageBG(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/icon/Clever Hands (1).png',
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffefdf35),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 30, right: 30),
                  child: Shimmer.fromColors(
                      child: Text(

                            'Welcome to Clever Hands Application',
                        style: TextStyle(fontSize: 15),
                      ),
                      baseColor: Colors.black,
                      highlightColor: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
