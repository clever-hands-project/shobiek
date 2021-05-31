import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/image_bg.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:shobek/src/Provider/auth/forgetPasswordProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/appIcon.dart';
import 'widget/backBtn.dart';
import 'widget/lockIcon.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _form = GlobalKey<FormState>();
  bool autoError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: [
          ImageBG(),
          Form(
            key: _form,
            autovalidateMode:
                autoError ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Stack(
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 40.0, right: 8, left: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.transparent.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, bottom: 60.0),
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
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Center(
                                            child: Text(
                                          "فضلا",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 36,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                            child: Text(
                                          "ادخل رقم الجوال ليصلك كود التفعيل",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                          textAlign: TextAlign.center,
                                        )),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        RegisterTextField(
                                          label: 'رقم الجوال',
                                          onChange: (v) {
                                             Provider.of<ForgetPasswordProvider>(context,listen: false).phone = v;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomBtn(
                                          txtColor: Colors.black,
                                          heigh: 50,
                                          onTap: () {
                                            setState(() {
                                              autoError = true;
                                            });
                                            final isValid =
                                                _form.currentState.validate();
                                            if (!isValid) {
                                              return;
                                            }
                                            _form.currentState.save();
                                           Provider.of<ForgetPasswordProvider>(context,listen: false).forgetPassword(context);
                                          },
                                          color: Theme.of(context).primaryColor,
                                          text: 'ارسال',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
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
                                  child: LockIcon()),
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
          ),
        ],
      ),
    );
  }
}
