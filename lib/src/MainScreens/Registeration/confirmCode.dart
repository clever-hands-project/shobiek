import 'dart:convert';
import 'package:shobek/src/Helpers/route.dart';
import 'package:shobek/src/MainScreens/Registeration/SignUpDriver.dart';
import 'package:shobek/src/MainScreens/Registeration/SignUpShop.dart';
import 'package:shobek/src/MainScreens/Registeration/SignUpUsers.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/image_bg.dart';
import 'package:shobek/src/Provider/auth/confirmResetCodeProvider.dart';
import 'package:shobek/src/Provider/changeData/changePhoneCodeProvider.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:provider/provider.dart';
import 'widget/lockIcon.dart';

class ConfirmCode extends StatefulWidget {
  final String phoneNumber;
  final int stateOfVerificationCode;

  const ConfirmCode({Key key, this.phoneNumber, this.stateOfVerificationCode})
      : super(key: key);

  @override
  _ConfirmCodeState createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  @override
  void initState() {
    super.initState();
  }

  final pinCodeController = TextEditingController();
  bool resend = false;
  int timer = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: <Widget>[
          ImageBG(),
          ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 40.0, right: 8, left: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, bottom: 20),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "تسجيل الدخول",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 15),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "فضلا",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "تم ارسال كود التفعل الي الرقم",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                      Center(
                                          child: Text(
                                        "${widget.phoneNumber ?? ""}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          10,
                                          20,
                                          10,
                                          30,
                                        ),
                                        child: Center(
                                          child: PinCodeTextField(
                                            appContext: context,
                                            controller: pinCodeController,
                                            length: 4,
                                            backgroundColor: Color(0x00000000),
                                            cursorColor:
                                                Theme.of(context).primaryColor,
                                            textStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            keyboardType: TextInputType.number,
                                            pinTheme: PinTheme(
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              selectedColor:
                                                  Theme.of(context).accentColor,
                                              inactiveColor:
                                                  Theme.of(context).accentColor,
                                            ),
                                            onChanged: (code) {},
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            autoFocus: true,
                                            onCompleted: (String value) {},
                                          ),
                                        ),
                                      ),
                                      // Reset Password
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        child: CustomBtn(
                                          heigh: 50,
                                          color: Theme.of(context).primaryColor,
                                          text: "ارسال",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          txtColor:
                                              Theme.of(context).accentColor,
                                          onTap: () {
                                            if (widget
                                                    .stateOfVerificationCode ==
                                                0)
                                            {
                                              // Provider.of<AuthController>(
                                              //         context,
                                              //         listen: false)
                                              //     .phoneVerification(context,
                                              //         pinCodeController.text)
                                              //     .then((value) {
                                              //   if (value == false) {
                                                  int type = Provider.of<
                                                              AuthController>(
                                                          context,
                                                          listen: false)
                                                      .type;
                                                  if (type == 1) {
                                                    push(
                                                        context, SignUpUsers());
                                                  } else if (type == 2) {
                                                    push(context,
                                                        SignUpDriver());
                                                  } else {
                                                    push(context, SignUpShop());
                                                  }
                                                }


                                            // else if (widget
                                            //         .stateOfVerificationCode ==
                                            //     1) {
                                            //        Provider.of<ConfirmResetCodeProvider>(
                                            //           context,
                                            //           listen: false).code = pinCodeController.text;
                                            //       Provider.of<ConfirmResetCodeProvider>(context,listen: false).confirmResetCode(context);
                                            // }
                                            // else {
                                            //
                                            //   Provider.of<ChangePhoneCodeProvider>(
                                            //           context,
                                            //           listen: false)
                                            //       .changePhoneCode(
                                            //           pinCodeController.text,
                                            //           widget.phoneNumber,
                                            //           context)
                                            //       .then((v) {
                                            //     if (v == true) {
                                            //       var auth = Provider.of<
                                            //               AuthController>(
                                            //           context,
                                            //           listen: false);
                                            //       auth.userModel.data
                                            //               .phoneNumber =
                                            //           widget.phoneNumber;
                                            //       auth.storageUserData(
                                            //           json.encode(auth.userModel
                                            //               .toJson()));
                                            //     }
                                            //   });
                                            // }
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Visibility(
                                        visible: resend,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            InkWell(
                                                child: new Text(
                                                  "اضغط هنا",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 13,
                                                      fontFamily: 'cairo',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    resend = !resend;
                                                  });
                                                  Provider.of<AuthController>(
                                                          context,
                                                          listen: false)
                                                      .resendCode(context);
                                                }),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "لاعادة ارسال كود التفعيل",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontFamily: 'cairo',
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      resend == true
                                          ? Container()
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              textDirection: TextDirection.rtl,
                                              children: <Widget>[
                                                Text(
                                                  localization
                                                      .text("confirm_code"),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                SizedBox(height: 10),
                                                Center(
                                                  child: SlideCountdownClock(
                                                    duration: Duration(
                                                        minutes: timer),
                                                    slideDirection:
                                                        SlideDirection.Down,
                                                    tightLabel: true,
                                                    onDone: () {
                                                      setState(() {
                                                        resend = true;
                                                      });
                                                    },
                                                    separator: ":",
                                                    textStyle: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 0, right: 0, top: -20, child: LockIcon()),
                          ],
                        ),
                        Spacer(flex: 2)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 20,
            child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
