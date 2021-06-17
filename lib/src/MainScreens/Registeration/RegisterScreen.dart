import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/route.dart';
import 'package:shobek/src/MainScreens/Registeration/registerMobilePage.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/image_bg.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'widget/appIcon.dart';
import 'widget/backBtn.dart';
import 'widget/lockIcon.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool autoError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: [
          ImageBG(),
          Stack(
            children: <Widget>[
              ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Spacer(flex: 3),
                        AppIcon(height: 150),
                        Spacer(flex: 3),
                        Stack(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  // top: 30.0,
                                  bottom: 30.0,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Column(
                                  children: [
                                    LockIcon(),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "تسجيل جديد",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Center(
                                      child: Text(
                                        "فضلا",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Center(
                                      child: Text(
                                        "اختر مستخدم للتسجيل في التطبيق",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    // Register as user
                                    CustomBtn(
                                      color: Colors.black,
                                      txtColor: Theme.of(context).primaryColor,
                                      heigh: 60,
                                      text: 'التسجيل كعميل',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      onTap: () {
                                        setState(() {
                                          Provider.of<AuthController>(context,
                                                  listen: false)
                                              .type = 1;
                                        });
                                        push(context, RegisterMobilePage());
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     builder: (_) => SignUpUsers(),
                                        //   ),
                                        // );
                                      },
                                    ),
                                    SizedBox(height: 5),
                                    // Register as shop
                                    CustomBtn(
                                      color: Colors.black,
                                      txtColor: Theme.of(context).primaryColor,
                                      heigh: 60,
                                      text: 'التسجيل كمتجر',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      onTap: () {
                                        setState(() {
                                          Provider.of<AuthController>(context,
                                                  listen: false)
                                              .type = 3;
                                        });
                                        push(context, RegisterMobilePage());
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     builder: (_) => SignUpShop(),
                                        //   ),
                                        // );
                                      },
                                    ),
                                    SizedBox(height: 5),
                                    // Register as Driver
                                    CustomBtn(
                                      color: Colors.black,
                                      txtColor: Theme.of(context).primaryColor,
                                      heigh: 60,
                                      text: 'التسجيل كمندوب',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      onTap: () {
                                        setState(() {
                                          Provider.of<AuthController>(context,
                                                  listen: false)
                                              .type = 2;
                                        });
                                        push(context, RegisterMobilePage());
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     builder: (_) => SignUpDriver(),
                                        //   ),
                                        // );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(flex: 2)
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(left: 10, top: 40, child: BackBtn())
            ],
          ),
        ],
      ),
    );
  }
}
