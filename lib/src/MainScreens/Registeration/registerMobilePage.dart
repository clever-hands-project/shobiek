import 'package:shobek/src/MainScreens/Registeration/confirmCode.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/image_bg.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/appIcon.dart';
import 'widget/backBtn.dart';
import 'widget/lockIcon.dart';

class RegisterMobilePage extends StatefulWidget {
  @override
  _RegisterMobilePageState createState() => _RegisterMobilePageState();
}

class _RegisterMobilePageState extends State<RegisterMobilePage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  final mobileController = TextEditingController();
  bool city = false;
  final _form = GlobalKey<FormState>();
  bool autoError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      key: _globalKey,
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            ImageBG(),
            SingleChildScrollView(
              child: Form(
                key: _form,
                autovalidateMode: autoError
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 10,
                      ),
                      child: BackBtn(),
                    ),
                    AppIcon(height: 150),
                    SizedBox(height: 50),
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
                              padding:
                                  const EdgeInsets.only(top: 30.0, bottom: 20),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "???? ???????? ???????? ?????? ????????????????",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  RegisterTextField(
                                    controller: mobileController,
                                    label: '?????? ????????????',
                                    // hint: '',
                                    // inValid: (String value) {
                                    //   if (value.isEmpty) {
                                    //     return "?????? ???????????? ??????????";
                                    //   } else if (!value.startsWith("05")) {
                                    //     return "?????? ?????? ???????? ???????????? ??05";
                                    //   } else if (value.length > 11 ||
                                    //       value.length < 11) {
                                    //     return "?????? ???? ???????? ???????????? ?????????? ???? 11 ??????";
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: CustomBtn(
                                      txtColor: Colors.black,
                                      heigh: 50,
                                      onTap: () {
                                        setState(() {
                                          autoError = true;
                                        });
                                        // final isValid =
                                        //     _form.currentState.validate();
                                        // if (!isValid) {
                                        //   return;
                                        // }
                                        _form.currentState.save();

                                        if (_form.currentState.validate()) {
                                          Provider.of<AuthController>(context,
                                                  listen: false)
                                              .phone = mobileController.text;
                                          Provider.of<AuthController>(context,
                                                  listen: false)
                                              .registerMobile(context)
                                              .then((value) {
                                            if (value == true) {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) => ConfirmCode(
                                                    phoneNumber:
                                                        mobileController.text,
                                                    stateOfVerificationCode: 0,
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                        }
                                      },
                                      color: Theme.of(context).primaryColor,
                                      text: '??????????',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: -20,
                          child: LockIcon(),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
