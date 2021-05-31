import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shobek/src/MainScreens/Intro/waitingScreen.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/customImageNetworkGetter.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/Provider/DriverProvider/editCarDataProvider.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';

class CarDocuments extends StatefulWidget {
  final String token;
  final SharedPreferences pref;

  const CarDocuments({Key key, this.token, this.pref}) : super(key: key);
  @override
  _CarDocumentsState createState() => _CarDocumentsState();
}

class _CarDocumentsState extends State<CarDocuments> {
  String _mainImgNetwork;
  String _carFormImgNetwork;
  String _forwardCarImgNetwork;

  @override
  void initState() {
    _mainImgNetwork = Provider.of<AuthController>(context, listen: false).userModel.data.identity;
    _carFormImgNetwork =
        Provider.of<AuthController>(context, listen: false).userModel.data.license;
    _forwardCarImgNetwork =
        Provider.of<AuthController>(context, listen: false).userModel.data.carForm;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "الهوية او الاقامة",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        GetImageNetwork().showMainImg(
          context: context,
          deleteImage: () {
            setState(() {
              _mainImg = null;
              _mainImgNetwork = null;
            });
          },
          mainImgNetwork: _mainImgNetwork,
          cameraBtn: _cameraBtn(
            onTap: () => bottomCameraSheet(0),
            icon: Icons.camera_alt,
            label: "",
            // "الهوية او الاقامة"
          ),
          mainImg: _mainImg,
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "رخصة القياة",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        GetImageNetwork().showMainImg(
          context: context,
          deleteImage: () {
            setState(() {
              _idImg = null;
              _carFormImgNetwork = null;
            });
          },
          cameraBtn: _cameraBtn(
            // onTap: () => _getMainImg(ImageSource.gallery, 1),
            onTap: () => bottomCameraSheet(1),
            icon: Icons.camera_alt,
            label: "",
          ),
          mainImg: _idImg,
          mainImgNetwork: _carFormImgNetwork,
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "استمارة السيارة",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        GetImageNetwork().showMainImg(
            context: context,
            deleteImage: () {
              setState(() {
                _carFormImg = null;
                _forwardCarImgNetwork = null;
              });
            },
            cameraBtn: _cameraBtn(
              // onTap: () => _getMainImg(ImageSource.gallery, 2),
              onTap: () => bottomCameraSheet(2),
              icon: Icons.camera_alt,

              label: "",
              //  "استمارة السيارة"
            ),
            mainImg: _carFormImg,
            mainImgNetwork: _forwardCarImgNetwork),
        SizedBox(height: 20),
        SizedBox(
          height: 20,
        ),
        CustomBtn(
          txtColor: Colors.black,
          color: Theme.of(context).primaryColor,
          text: "تعديل",
          onTap: () {
            if (_mainImg == null &&
                _idImg == null &&
                _carFormImg == null &&
                _forwardCarImg == null &&
                _carImg == null) {
              CustomAlert().toast(
                context: context,
                title: "لم يتم اضافة اي تعديل",
              );

              return;
            }
            _showDialog(
                "عند تعديل بيانات السيارة سيتم ايقاف الحساب لحين الموافقة من الادارة",
                context);
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _showDialog(String text, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 3,
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.all(15),
            children: <Widget>[
              Container(
                height: 50,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Directionality(
                    textDirection:
                       TextDirection.rtl,
                    child: Text(
                      text,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Provider.of<EditCarDataProvider>(context, listen: false)
                            .changeCarData(widget.token, context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WaitingAccepting(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Container(
                          width: 50,
                          height: 30,
                          child: Center(
                              child: Text(
                                  "متاكد"
                                  )))),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 50,
                          height: 30,
                          child: Center(
                              child: Text(
                                  "الغاء"
                                  ))))
                ],
              )
            ],
          );
        });
  }

  bottomCameraSheet(int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Material(
          type: MaterialType.transparency,
          child: Opacity(
            opacity: 1.0,
            child: Container(
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _getMainImg(ImageSource.camera, index);
                    },
                    child: _roundedButton(
                      label: "Camera",
                      bgColor: Theme.of(context).primaryColor,
                      txtColor: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _getMainImg(ImageSource.gallery, index);
                    },
                    child: _roundedButton(
                      label: "Gallery",
                      bgColor: Theme.of(context).primaryColor,
                      txtColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: new Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      child: _roundedButton(
                        label: "Cancel",
                        bgColor: Colors.black,
                        txtColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _roundedButton({String label, Color bgColor, Color txtColor}) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(100.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        label,
        style: new TextStyle(
          color: txtColor,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _getMainImg(ImageSource source, int currentImage) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      switch (currentImage) {
        case 0:
          return setState(() {
            _mainImg = File(image.path);
            Provider.of<EditCarDataProvider>(context, listen: false).identity =
                _mainImg;
          });
        case 1:
          return setState(() {
            _idImg = File(image.path);
            Provider.of<EditCarDataProvider>(context, listen: false).license =
                _idImg;
          });
        case 2:
          return setState(() {
            _carFormImg = File(image.path);
            Provider.of<EditCarDataProvider>(context, listen: false).carForm =
                _carFormImg;
          });
        case 3:
          return setState(() {
            _forwardCarImg = File(image.path);
            // Provider.of<EditCarDataProvider>(context, listen: false)
            //     .transportationCard = _forwardCarImg;
          });
        case 4:
          return setState(() {
            // _carImg = File(image.path);
            // Provider.of<EditCarDataProvider>(context, listen: false).insurance =
            //     _carImg;
          });
          break;
      }
    });
    // registerBloc.updatePersonalImg(image);
  }

  Widget _cameraBtn({Function onTap, String label, IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon),
                Expanded(
                    child: Text(
                  label,
                  textAlign: TextAlign.end,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  File _mainImg;
  File _carFormImg;
  File _forwardCarImg;
  File _idImg;
  File _carImg;
}
