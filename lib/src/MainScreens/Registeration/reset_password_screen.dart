import 'package:provider/provider.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/image_bg.dart';
import 'package:shobek/src/MainWidgets/register_secure_text_field.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Provider/auth/resetPasswordProvider.dart';
import 'widget/appIcon.dart';
import 'widget/lockIcon.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String code;
  final String phone;

  const ResetPasswordScreen({Key key, this.code, this.phone})
      : super(key: key);
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Spacer(flex: 3),
                      AppIcon(height: 150),
                      Spacer(flex: 3),
                      Stack(children: [
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
                                    child: Column(children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'تغير كلمة المرور',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 15),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      RegisterSecureTextField(
                                        label: "كلمة المرور الجديدة",
                                        onChange: (v) {
                                          Provider.of<ResetPasswordProvider>(context,listen: false).password = v;
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      RegisterSecureTextField(
                                        label: "تأكيد كلمة المرور",
                                        onChange: (v) {
                                          Provider.of<ResetPasswordProvider>(context,listen: false).passwordConfirmation = v;
                                        },
                                      ),
                                      SizedBox(height: 20),
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
                                            final isValid =
                                                _form.currentState.validate();
                                            if (isValid) {
                                               Provider.of<ResetPasswordProvider>(context,listen: false).resetPassword(context);
                                            } else {
                                              return;
                                            }
                                            _form.currentState.save();
                                          },
                                          color: Theme.of(context).primaryColor,
                                          text: 'حفظ',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ])))),
                        Positioned(
                            left: 0, right: 0, top: -20, child: LockIcon())
                      ]),
                      Spacer(flex: 2)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
