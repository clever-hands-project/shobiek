import 'package:shobek/src/Helpers/route.dart';
import 'package:shobek/src/MainScreens/driver/driverMainPage.dart';
import 'package:shobek/src/MainScreens/mainPage.dart';
import 'package:shobek/src/MainScreens/shop/ShopMainPage.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/image_bg.dart';
import 'package:shobek/src/MainWidgets/register_secure_text_field.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import '../../Provider/auth/loginProvider.dart';
import 'RegisterScreen.dart';
import 'forgotPasswordScreen.dart';
import 'widget/appIcon.dart';
import 'widget/lockIcon.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _form = GlobalKey<FormState>();
  bool autoError = false;
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).accentColor,
        body: Stack(
          children: [
            ImageBG(),
            Form(
                key: _form,
                autovalidateMode: autoError
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Stack(children: <Widget>[
                  ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Spacer(flex: 3),
                                  AppIcon(height: 300),
                                  Stack(children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 40.0, right: 8, left: 8,bottom: 50),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.transparent
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30.0, bottom: 20),
                                                child: Column(children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          "تسجيل الدخول",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 15))),
                                                  SizedBox(height: 30),
                                                  RegisterTextField(
                                                      controller:
                                                          phoneController,
                                                      label: 'رقم الجوال',
                                                      onChange: (v) {
                                                        loginProvider.phone = v;
                                                      }),
                                                  SizedBox(height: 20),
                                                  RegisterSecureTextField(
                                                      controller:
                                                          passwordController,
                                                      label: "كلمة المرور",
                                                      onChange: (v) {
                                                        loginProvider.password =
                                                            v;
                                                      }),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: TextButton(
                                                        child: Text(
                                                            'نسيت كلمة المرور ؟',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  ForgotPasswordScreen(),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                  CustomBtn(
                                                    txtColor: Colors.black,
                                                    heigh: 45,
                                                    onTap: () {
                                                      setState(() {
                                                        autoError = true;
                                                      });
                                                      final isValid = _form
                                                          .currentState
                                                          .validate();
                                                      if (!isValid) {
                                                        return;
                                                      }
                                                      _form.currentState.save();
                                                      Provider.of<AuthController>(
                                                                  context,
                                                                  listen: false)
                                                              .phone =
                                                          phoneController.text;
                                                      Provider.of<AuthController>(
                                                              context,
                                                              listen: false)
                                                          .login(
                                                        context,
                                                        password:
                                                            passwordController
                                                                .text,
                                                      )
                                                          .then((value) {
                                                        if (value == true) {
                                                          int type = Provider
                                                                  .of<AuthController>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                              .type;
                                                          if (type == 1) {
                                                            pushAndRemoveUntil(
                                                                context,
                                                                MainPage());
                                                          } else if (type ==
                                                              2) {
                                                            pushAndRemoveUntil(
                                                                context,
                                                                DriverMainPage());
                                                          } else {
                                                            pushAndRemoveUntil(
                                                                context,
                                                                ShopMainPage());
                                                          }
                                                        }
                                                      });
                                                    },
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    text: 'دخول',
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Center(
                                                            child: TextButton(
                                                                child: Text(
                                                                    "تسجيل جديد",
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .primaryColor)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (_) =>
                                                                              RegisterScreen()));
                                                                })),
                                                        Text('ليس عندك حساب ؟',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15)),
                                                      ])
                                                ])))),
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        top: -20,
                                        child: LockIcon())
                                  ]),
                                  Spacer(flex: 2),
                                ]))
                      ])
                ])),
          ],
        ));
  }
}
