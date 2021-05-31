import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/chargeBankProvider.dart';

class BankingPay extends StatefulWidget {
  final String price;

  const BankingPay({
    Key key,
    this.price,
  }) : super(key: key);
  @override
  _BankingPayState createState() => _BankingPayState();
}

class _BankingPayState extends State<BankingPay> {
  File _mainImg;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CustomDialog dialog = CustomDialog();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "الحساب البنكي",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                ),
                _showMainImg("ادخل صوره اصال التحويل"),
                Padding(
                  padding: const EdgeInsets.only(right: 50, left: 50, top: 50),
                  child: CustomBtn(
                    onTap: () {
                      if (_mainImg == null) {
                        CustomAlert()
                            .toast(title: "يجب ارفاق الصورة", context: context);
                      } else {
                        Provider.of<ChargeBankProvider>(context, listen: false)
                            .subscribe(
                                Provider.of<SharedPref>(context, listen: false)
                                    .token,
                                widget.price,
                                _mainImg,
                                context);
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    text: "إرسال",
                    txtColor: Colors.black,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  onSave() {
    if (_mainImg == null) {
    } else {}
  }

  _showMainImg(String txt) {
    if (_mainImg != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _mainImg,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _mainImg = null;
                  });
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              bottom: 10,
              left: 10,
            ),
          ],
        ),
      );
    } else {
      return _cameraBtn(
          icon: Icons.camera_alt,
          label: txt,
          onTap: () {
            _getMainImg(ImageSource.gallery);
          });
    }
  }

  Widget _cameraBtn({Function onTap, String label, IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color.fromRGBO(220, 220, 220, 1))),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[Icon(icon), Text(label)],
            ),
          ),
        ),
      ),
    );
  }

  _getMainImg(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      _mainImg = image;
    });
  }
}
