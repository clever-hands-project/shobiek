import 'package:location/location.dart';
import 'package:shobek/src/Helpers/map_helper.dart';
import 'package:shobek/src/MainScreens/Intro/waitingScreen.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/image_bg.dart';
import 'package:shobek/src/MainWidgets/register_image_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shobek/src/Provider/get/RegisterHelper.dart';
import 'package:shobek/src/MainWidgets/register_secure_text_field.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'dart:io';
import 'package:shobek/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:shobek/src/MainWidgets/terms_dialog.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Provider/termsProvider.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Helpers/route.dart';
import 'package:provider/provider.dart';
import 'widget/appIcon.dart';
import 'widget/backBtn.dart';
import 'widget/lockIcon.dart';

class SignUpDriver extends StatefulWidget {
  @override
  _SignUpDriverState createState() => _SignUpDriverState();
}

class _SignUpDriverState extends State<SignUpDriver> {
  bool _accept = false;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  File _driverImage;
  File _driverID;
  File _driverLicence;
  File _driverCarLicence;
  final picker = ImagePicker;
  @override
  void initState() {
    Provider.of<MapHelper>(context, listen: false).getLocation();
    Provider.of<TermsProvider>(context, listen: false).getTerms();
    Provider.of<RegisterHelper>(context, listen: false).getRogine(context);
    Provider.of<RegisterHelper>(context, listen: false).getDepartment(context);
    super.initState();
  }

  Future<File> getImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  bool city = false;
  final _form = GlobalKey<FormState>();
  bool autoError = false;
  final name = TextEditingController();
  final password = TextEditingController();
  final rePassword = TextEditingController();
  String _carType;
  String _city;
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
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 30.0,
                                bottom: 20,
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "تسجيل جديد كمندوب",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  RegisterTextField(
                                    controller: name,
                                    label: 'الاسم',
                                    hint: "اكتب اسم المندوب",
                                    type: TextInputType.text,
                                    leghth: 20,
                                  ),
                                  SizedBox(height: 20),
                                  RegisterImageField(
                                    onTap: () async {
                                      _driverImage = await getImage();
                                      setState(() {});
                                    },
                                    label: "صورة المندوب",
                                    hint: _driverImage != null
                                        ? _driverImage.path.split('/').last
                                        : "اضغط لارفاق صورة",
                                  ),
                                  LabeledBottomSheet(
                                    label: "اختر المنطقة",
                                    onChange: (v) async {
                                      setState(() {
                                        city = false;
                                      });
                                      // Provider.of<SignUpProvider>(context, listen: false).regionId =
                                      //     v.id.toString();
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
                                        // Provider.of<EditUserDataProvider>(context,
                                        //         listen: false)
                                        //     .cityId = v.id.toString();
                                        _city = v;
                                      },
                                      ontap: city,
                                      data: Provider.of<RegisterHelper>(context,
                                                  listen: true)
                                              .cities ??
                                          [],
                                    ),
                                  SizedBox(height: 20),
                                  // RegisterImageField(
                                  //   label: "صورة الهوية",
                                  //   hint: "اضغط لارفاق صورة",
                                  // ),
                                  RegisterImageField(
                                    onTap: () async {
                                      _driverID = await getImage();
                                      setState(() {});
                                    },
                                    label: "صورة الهوية",
                                    hint: _driverID != null
                                        ? _driverID.path.split('/').last
                                        : "اضغط لارفاق صورة",
                                  ),
                                  SizedBox(height: 20),
                                  RegisterImageField(
                                    onTap: () async {
                                      _driverLicence = await getImage();
                                      setState(() {});
                                    },
                                    label: "استمارة السائق",
                                    hint: _driverLicence != null
                                        ? _driverLicence.path.split('/').last
                                        : "اضغط لارفاق صورة",
                                  ),
                                  SizedBox(height: 20),
                                  RegisterImageField(
                                    onTap: () async {
                                      _driverCarLicence = await getImage();
                                      setState(() {});
                                    },
                                    label: "استمارة السيارة",
                                    hint: _driverCarLicence != null
                                        ? _driverCarLicence.path.split('/').last
                                        : "اضغط لارفاق صورة",
                                  ),
                                  // SizedBox(height: 10),
                                  // ListSelectorWidget(
                                  //   label: "نوع السيارة",
                                  //   hint: "اختر نوع السيارة",
                                  //   items: ["سيارة", "دراجة نارية"],
                                  //   onSelect: (value) {},
                                  // ),
                                  LabeledBottomSheet(
                                    label: "نوع السيارة",
                                    onChange: (v) {
                                      _carType = v;
                                    },
                                    ontap: true,
                                    data: [
                                      CarType("0", "سيارة عادية"),
                                      CarType("1", "سيارة مبردة")
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  RegisterSecureTextField(
                                    controller: password,
                                    label: "كلمة المرور",
                                    // icon: Icons.lock,
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
                                              .register(
                                            context,
                                            name: name.text,
                                            photo: _driverImage,
                                            cityId: _city,
                                            identity: _driverID,
                                            license: _driverLicence,
                                            carForm: _driverCarLicence,
                                            carType: _carType,
                                            password: password.text,
                                            passwordConfirm: rePassword.text,
                                          )
                                              .then((value) {
                                            if (value == true) {
                                              // pushAndRemoveUntil(
                                              //     context, DriverMainPage());
                                              pushAndRemoveUntil(
                                                  context, WaitingAccepting());
                                            }
                                          });
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(
                                          //         builder: (_) => MainPage()));
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
                            left: 0, right: 0, top: -20, child: LockIcon()),
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

class CarType {
  String id;
  String name;
  CarType(this.id, this.name);
}
