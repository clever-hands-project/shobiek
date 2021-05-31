import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/Widgets/ImagePicker/image_picker_handler.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/profileAppBar.dart';
import 'package:shobek/src/MainWidgets/register_secure_text_field.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Provider/changeData/changePhoneProvider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key key,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  ImagePickerHandler imagePicker;
  AnimationController _controller;

  String name;

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
      Provider.of<AuthController>(context, listen: false).photo = _image;
    });
  }

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(
        this, _controller, Color.fromRGBO(12, 169, 149, 1));
    imagePicker.init();
    super.initState();
  }

  String oldPassword = "";
  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final rePass = TextEditingController();
  final passForm = GlobalKey<FormState>();
  final _form = GlobalKey<FormState>();
  bool autoError = false;
  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<AuthController>(context, listen: true);

    return Scaffold(
      body: Form(
        key: _form,
        autovalidateMode:
            autoError ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          children: [
            ProfileAppBar(
              title: "تعديل بيانات الحساب",
              name: "${userController.userModel.data.name}",
              hasBack: true,
              onBack: () => Navigator.pop(context),
              image: InkWell(
                onTap: () => imagePicker.showDialog(context),
                child: _image == null
                    ? userController.userModel.data.photo != null
                        ? CachedNetworkImage(
                            imageUrl: userController.userModel.data.photo,
                            fadeInDuration: Duration(seconds: 2),
                            placeholder: (context, url) => CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.jpeg')),
                            imageBuilder: (context, provider) {
                              return CircleAvatar(
                                  radius: 40, backgroundImage: provider);
                            },
                          )
                        : CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/avatar.jpeg'))
                    : Container(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: Image.file(_image).image,
                        ),
                      ),
              ),
              icon: InkWell(
                onTap: () => imagePicker.showDialog(context),
                child: CircleAvatar(
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 15,
                  ),
                  radius: 10,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 70,
                ),
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Spacer(flex: 1),
                          // name
                          RegisterTextField(
                            onChange: (v) {
                              setState(() {
                                name = v;
                              });
                              userController.name = v;
                            },
                            label: 'الاسم',
                            init: "${userController.userModel.data.name}",
                            type: TextInputType.text,
                            edit: true,
                            leghth: 20,
                          ),
                          Spacer(flex: 1),
                          CustomBtn(
                            txtColor: Colors.black,
                            heigh: 50,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            onTap: () {
                              userController.editUserData(
                                context,
                              );
                              // print("please fill oldPassword Field");
                            },
                            color: Theme.of(context).primaryColor,
                            text: 'حفظ',
                          ),
                          Spacer(flex: 2),
                          // phone
                          RegisterTextField(
                            onChange: (v) {
                              Provider.of<ChangeMobileProvider>(context,
                                      listen: false)
                                  .phone = v;
                            },
                            label: 'رقم الجوال',
                            init:
                                "${userController.userModel.data.phoneNumber}",
                            edit: true,
                          ),
                          Spacer(flex: 1),
                          CustomBtn(
                            txtColor: Colors.black,
                            heigh: 50,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            onTap: () {
                              setState(() {
                                autoError = true;
                              });
                              final isValid = _form.currentState.validate();
                              if (!isValid) {
                                return;
                              }
                              _form.currentState.save();
                              Provider.of<ChangeMobileProvider>(context,
                                      listen: false)
                                  .changeMobile("token", context);
                            },
                            color: Theme.of(context).primaryColor,
                            text: 'حفظ',
                          ),
                          Spacer(flex: 2),
                          // Change password title
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              "تغيير كلمة المرور",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // old password
                          Form(
                            key: passForm,
                            child: Column(
                              children: [
                                RegisterSecureTextField(
                                  label: "كلمة المرور القديمة",
                                  // onChange: (v) {
                                  //   setState(() {
                                  //     oldPassword = v;
                                  //   });
                                  // },
                                  controller: oldPass,
                                ),
                                SizedBox(height: 10),
                                // new password
                                RegisterSecureTextField(
                                  label: "كلمة المرور الجديدة",
                                  controller: newPass,
                                ),
                                SizedBox(height: 10),
                                // new password
                                RegisterSecureTextField(
                                  label: "كلمة المرور الجديدة",
                                  controller: rePass,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  CustomBtn(
                    txtColor: Colors.black,
                    heigh: 50,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    onTap: () {
                      // if (oldPassword.isNotEmpty) Navigator.pop(context);
                      // if (oldPassword.isEmpty)
                      if (passForm.currentState.validate()) {
                        userController.editPassword(
                          context,
                          newPass: newPass.text,
                          oldPass: oldPass.text,
                          regPass: rePass.text,
                        );
                      }
                      print("please fill oldPassword Field");
                    },
                    color: Theme.of(context).primaryColor,
                    text: 'حفظ',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
