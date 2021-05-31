import 'dart:io';
import 'package:location/location.dart';
import 'package:shobek/src/Helpers/map_helper.dart';
import 'package:shobek/src/MainScreens/Intro/waitingScreen.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/image_bg.dart';
import 'package:shobek/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shobek/src/MainWidgets/register_image_field.dart';
import 'package:shobek/src/MainWidgets/register_secure_text_field.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:shobek/src/MainWidgets/terms_dialog.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Provider/get/RegisterHelper.dart';
import 'package:shobek/src/Provider/termsProvider.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Helpers/route.dart';
import 'package:provider/provider.dart';
import 'widget/appIcon.dart';
import 'widget/backBtn.dart';
import 'widget/lockIcon.dart';

class SignUpShop extends StatefulWidget {
  @override
  _SignUpShopState createState() => _SignUpShopState();
}

class _SignUpShopState extends State<SignUpShop> {
  bool _accept = false;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    Provider.of<MapHelper>(context, listen: false).getLocation();
    Provider.of<TermsProvider>(context, listen: false).getTerms();
    Provider.of<RegisterHelper>(context, listen: false).getRogine(context);
    Provider.of<RegisterHelper>(context, listen: false).getDepartment(context);

    super.initState();
  }

  Future getImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String zone, ciity, category;
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  TextEditingController descreption = TextEditingController();
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
        height: MediaQuery.of(context).size.height * 1,
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
                            top: 40.0,
                            right: 8,
                            left: 8,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 30.0,
                                bottom: 20,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "تسجيل جديد كمتجر",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  RegisterTextField(
                                    controller: name,
                                    label: 'الاسم',
                                    hint: 'اكتب اسم المتجر',
                                    type: TextInputType.text,
                                    leghth: 20,
                                  ),
                                  SizedBox(height: 20),
                                  RegisterImageField(
                                    onTap: getImage,
                                    label: "صورة المتجر",
                                    hint: _image != null
                                        ? _image.path.split('/').last
                                        : "اضغط لارفاق صورة",
                                  ),
                                  SizedBox(height: 5),
                                  LabeledBottomSheet(
                                    label: "اختر المنطقة",
                                    onChange: (v) async {
                                      setState(() {
                                        city = false;
                                      });
                                      print("$v");
                                      await Provider.of<RegisterHelper>(context,
                                              listen: false)
                                          .getCities(context, v);

                                      setState(() {
                                        city = true;
                                      });
                                    },
                                    data: Provider.of<RegisterHelper>(context,
                                            listen: true)
                                        .rogine,
                                  ),
                                  if (city == true)
                                    LabeledBottomSheet(
                                      label: "اختر المدينه",
                                      onChange: (v) {
                                        ciity = v;
                                      },
                                      ontap: city,
                                      data: Provider.of<RegisterHelper>(context,
                                                  listen: true)
                                              .cities ??
                                          [],
                                    ),
                                  SizedBox(height: 20),
                                  RegisterTextField(
                                    controller: location,
                                    label: 'العنوان',
                                    hint: 'يوضع العنوان بالتفصيل',
                                    type: TextInputType.text,
                                  ),
                                  SizedBox(height: 20),
                                  LabeledBottomSheet(
                                    label: "القسم التابع له المتجر",
                                    onChange: (v) {
                                      category = v;
                                    },
                                    ontap: true,
                                    data: Provider.of<RegisterHelper>(context,
                                            listen: true)
                                        .depart,
                                  ),
                                  SizedBox(height: 20),
                                  RegisterTextField(
                                    maxLines: 4,
                                    controller: descreption,
                                    label: 'التفاصيل',
                                    hint: 'اكتب تفاصيل المتجر',
                                    type: TextInputType.text,
                                  ),
                                  SizedBox(height: 20),
                                  RegisterSecureTextField(
                                    controller: password,
                                    label: "كلمة المرور",
                                  ),
                                  SizedBox(height: 20),
                                  RegisterSecureTextField(
                                    controller: rePassword,
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
                                        _form.currentState.save();

                                        if (_accept == false) {
                                          CustomAlert().toast(
                                              context: context,
                                              title:
                                                  'يجب الموافقة على الشروط والأحكام');
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
                                              .register(context,
                                                  address: location.text,
                                                  name: name.text,
                                                  password: password.text,
                                                  details: descreption.text,
                                                  departmentId: category,
                                                  photo: _image,
                                                  passwordConfirm:
                                                      rePassword.text,
                                                  cityId: ciity)
                                              .then((value) {
                                            if (value == true) {
                                              // pushAndRemoveUntil(
                                              //     context, ShopMainPage());
                                              pushAndRemoveUntil(
                                                  context, WaitingAccepting());
                                            }
                                          });
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
