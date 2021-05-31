import 'dart:io';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/Widgets/ImagePicker/image_picker_handler.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:shobek/src/MainWidgets/mapCard.dart';
import 'package:shobek/src/MainWidgets/multI_image_btn_sheet.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:shobek/src/Models/auth/AuthModle.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Provider/deleteShopPhoto.Provider.dart';
import 'package:shobek/src/Provider/depatmentsProvider.dart';

import 'package:shobek/src/Repository/networkUtlis.dart';

class EditShopPage extends StatefulWidget {
  @override
  _EditShopPageState createState() => _EditShopPageState();
}

class _EditShopPageState extends State<EditShopPage>
    with TickerProviderStateMixin, ImagePickerListener {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ImagePickerHandler imagePicker;
  AnimationController _controller;
  AuthController userController;
  String name;
  List<File> _img = [];
  List<Asset> files = [];
  List<Asset> filesAsset = [];
  UserData userData;
  @override
  userImage(File _image) {
    setState(() {});
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
    Provider.of<DepartMentProvider>(context, listen: false)
        .getDepartements(context);

    userController = Provider.of<AuthController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userData =
        Provider.of<AuthController>(context, listen: true).userModel.data;
    return Scaffold(
      key: _scaffoldKey,
      appBar: defaultAppBar(
        context: context,
        title: "تعديل بيانات المتجر",
        hasBack: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          (_img.length > 0 ||
                      (userData.photos != null &&
                          userData.photos.length > 0)) ==
                  true
              ? Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    height: 120,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: userData.photos.length,
                      itemBuilder: (context, index) {
                        return _oneImgNetwork(userData.photos[index].photo,
                            index, userData.photos[index].id);
                      },
                    ),
                  ),
                )
              : Container(),
          _img.length != 0 || filesAsset.length != 0
              ? Container(
                  height: 150,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      (filesAsset.length < 1) == true
                          ? Container()
                          : Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                height: 120,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: filesAsset.length,
                                  itemBuilder: (context, index) {
                                    return _oneImgFileAsset(
                                        filesAsset[index], index);
                                  },
                                ),
                              ),
                            ),
                      _img.length < 1 == true
                          ? Container()
                          : Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                height: 120,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _img.length,
                                  itemBuilder: (context, index) {
                                    return _oneImgFile(_img[index], index);
                                  },
                                ),
                              ),
                            )
                    ],
                  ),
                )
              : Container(),
          SizedBox(height: 20),
          // userData.photos != null &&
          //         userData.photos.length + _img.length + filesAsset.length > 5
          //     ?
          InkWell(
            onTap: () => ImagePickerDialogBtSheet().show(
                context: context,
                onGet: (f, v) {
                  if (v == 0)
                    setState(() {
                      filesAsset.addAll(f);
                    });
                  else {
                    setState(() {
                      _img.add(f);
                    });
                  }
                  return;
                }),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color.fromRGBO(220, 220, 220, 1))),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.photo),
                    Text(
                      "المعرض",
                    )
                  ],
                ),
              ),
            ),
          ),
          // : SizedBox(),
          SizedBox(height: 10,),
          RegisterTextField(
            maxLines: 4,
            onChange: (v) {
              Provider.of<AuthController>(context, listen: false).details = v;
            },
            label: 'التفاصيل',
            hint: 'اكتب تفاصيل المتجر',
            init:  Provider.of<AuthController>(context, listen: false).userModel.data.details,
            type: TextInputType.text,
          ),
          SizedBox(height: 10),
          LabeledBottomSheet(
            label: userData.department,
            onChange: (v) {
              Provider.of<AuthController>(context, listen: false).departMentId =
                  v.id.toString();
            },
            data: Provider.of<DepartMentProvider>(context, listen: true)
                .cotiesSheet,
          ),
          SizedBox(height: 10),
          MapCard(
            scaffoldKey: _scaffoldKey,
            onTap: () {
              Navigator.pop(context);
            },
            withAppBar: true,
            onChange: (v) {
              Provider.of<AuthController>(context, listen: false).lat =
                  v.latitude.toString();
              Provider.of<AuthController>(context, listen: false).long =
                  v.longitude.toString();
            },
            onTextChange: (v) {
              // Provider.of<AuthController>(context, listen: false)
              //      = v;
            },
            //  lable: "وين نوصل طلبك",
          ),
          SizedBox(height: 10),
          CustomBtn(
            txtColor: Colors.black,
            heigh: 50,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            onTap: () async {
              print(filesAsset.length);
              userController.photos = filesAsset;
              await userController.editUserData(
                context,
              );

              print("please fill oldPassword Field");
            },
            color: Theme.of(context).primaryColor,
            text: 'حفظ',
          ),
        ],
      ),
    );
  }

  Widget _oneImgFile(File img, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    img,
                    // width: 300,
                    // height: 300,
                  )),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  _img.removeAt(index);
                });
              },
              child: Material(
                color: Colors.white,
                elevation: 2,
                shape: CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.close, size: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _oneImgFileAsset(Asset img, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AssetThumb(
                    asset: img,
                    width: 300,
                    height: 300,
                  )),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  filesAsset.removeAt(index);
                });
              },
              child: Material(
                color: Colors.white,
                elevation: 2,
                shape: CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.close, size: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _oneImgNetwork(String img, int index, int id) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    img,
                  )),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  if (userData.photos.length == 1) {
                    CustomAlert()
                        .toast(context: context, title: "لا يمكن الحذف");
                  } else {
                    userData.photos.removeAt(index);
                    Provider.of<DeleteShopPhotoProvider>(context, listen: false)
                        .deletNot(NetworkUtil.token, id, context);
                  }
                });
              },
              child: Material(
                color: Colors.white,
                elevation: 2,
                shape: CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.close, size: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
