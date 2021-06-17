import 'package:location/location.dart';
import 'package:shobek/src/Helpers/map_helper.dart';
import 'package:shobek/src/Helpers/route.dart';
// import 'package:shobek/src/MainScreens/shop/ShopMainPage/ShopMainPage.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/image_bg.dart';
import 'package:shobek/src/MainWidgets/register_secure_text_field.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:shobek/src/MainWidgets/terms_dialog.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Provider/termsProvider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../mainPage.dart';
import 'widget/appIcon.dart';
import 'widget/backBtn.dart';
import 'widget/lockIcon.dart';

class SignUpUsers extends StatefulWidget {
  @override
  _SignUpUsersState createState() => _SignUpUsersState();
}

class _SignUpUsersState extends State<SignUpUsers> {
  bool _accept = false;
  FirebaseMessaging _fcm = FirebaseMessaging();
  String _deviceToken;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<MapHelper>(context, listen: false).getLocation();
    Provider.of<TermsProvider>(context, listen: false).getTerms();
    _fcm.getToken().then((response) {
      setState(() {
        _deviceToken = response;
      });
      print('The device Token is :' + _deviceToken);
    });
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();

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
                        left: 10,
                      ),
                      child: BackBtn(),
                    ),
                    AppIcon(height: 150),
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
                                      "تسجيل جديد كعميل",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  RegisterTextField(
                                    controller: nameController,
                                    // icon: Icons.person,
                                    onChange: (v) {},
                                    label: 'الاسم',
                                    hint: "اكتب اسم العميل",
                                    type: TextInputType.text,
                                    leghth: 20,
                                  ),
                                  SizedBox(height: 20),
                                  RegisterSecureTextField(
                                    controller: password,
                                    onChange: (v) {},
                                    label: "كلمة المرور",
                                    // icon: Icons.lock,
                                  ),
                                  SizedBox(height: 20),
                                  RegisterSecureTextField(
                                    controller: passwordConfirm,
                                    onChange: (v) {},
                                    // icon: Icons.lock,
                                    label: 'تأكيد كلمة المرور',
                                  ),
                                  SizedBox(height: 20),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.white),
                                    child: CheckboxListTile(
                                      value: _accept,
                                      onChanged: (value) {
                                        setState(() {
                                          _accept = !_accept;
                                        });
                                      },
                                      checkColor:
                                          Theme.of(context).primaryColor,
                                      activeColor: Color(0xff414141),
                                      dense: true,
                                      title: InkWell(
                                        onTap: () => TermsDialog()
                                            .show(context: context),
                                        child: Text(
                                          'اوافق على الشروط والأحكام',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: CustomBtn(
                                      txtColor: Colors.black,
                                      heigh: 50,
                                      onTap: () async {
                                        setState(() {
                                          autoError = true;
                                        });
                                        // final isValid =
                                        //     _form.currentState.validate();
                                        // if (!isValid) {
                                        //   return;
                                        // }
                                        _form.currentState.save();

                                        if (_accept == false) {
                                          CustomAlert().toast(
                                            context: context,
                                            title:
                                                'يجب الموافقة على الشروط والأحكام',
                                          );
                                        }
                                        if (!await Location()
                                            .serviceEnabled()) {
                                          CustomAlert().toast(
                                              context: context,
                                              title:
                                                  'يجب تشغيل خاصية تجديد المواقع');
                                          await Provider.of<MapHelper>(context,
                                                  listen: false)
                                              .getLocation();
                                        } else {
                                          _form.currentState.save();
                                          Provider.of<AuthController>(context,
                                                  listen: false)
                                              .register(
                                            context,
                                            name: nameController.text,
                                            password: password.text,
                                            passwordConfirm:
                                                passwordConfirm.text,
                                          )
                                              .then((value) {
                                            if (value == true) {
                                              pushAndRemoveUntil(
                                                  context, MainPage());
                                            }
                                          });
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (_) => MainPage(),
                                          //   ),
                                          // );
                                        }
                                      },
                                      color: Theme.of(context).primaryColor,
                                      text: 'تسجيل',
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
