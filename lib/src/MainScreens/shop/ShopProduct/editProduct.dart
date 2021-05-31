import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainWidgets/buttonSignIn.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/MainWidgets/details_text_field_no_img%20copy.dart';
import 'package:shobek/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:shobek/src/MainWidgets/multI_image_btn_sheet.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:shobek/src/Models/shop/deletePhotoProvider.dart';
import 'package:shobek/src/Models/shop/myProductModle.dart';
import 'package:shobek/src/Provider/shop/editProductProvider.dart';
import 'package:shobek/src/Provider/shop/productCatogoryProvider.dart';

class EditProduct extends StatefulWidget {
  final ShopProduct shopProduct;

  const EditProduct({Key key, this.shopProduct}) : super(key: key);
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<ProductCategoryProvider>(context, listen: false)
        .getServicesCatogory(context);
    Future.delayed(Duration(microseconds: 150), () {
      Provider.of<EditProductProvider>(context, listen: false).setNull();
    });

    super.initState();
  }

  final _form = GlobalKey<FormState>();
  bool autoError = false;
  List<File> _img = [];
  List<Asset> files = [];
  List<Asset> filesAsset = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: defaultAppBar(
        context: context,
        title: "تعديل بيانات المنتج",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: Form(
        key: _form,
        autovalidateMode:
            autoError ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            RegisterTextField(
              label: ' اسم المنتج',
              leghth: 25,
              hint: "يكتب هنا اسم المنتج",
              type: TextInputType.text,
              init: widget.shopProduct.name,
              onChange: (v) {
                Provider.of<EditProductProvider>(context, listen: false)
                    .placeName = v;
              },
            ),
            LabeledBottomSheet(
                label: '-- ${widget.shopProduct.category} --',
                onChange: (v) {
                  Provider.of<EditProductProvider>(context, listen: false)
                      .categoryId = v.toString();
                },
                data:
                    Provider.of<ProductCategoryProvider>(context, listen: true)
                        .bottomSheet),
            SizedBox(height: 20),
            DetailsTextFieldNoImg(
              hint: 'يكتب هنا التفاصيل العامة ',
              init: widget.shopProduct.details,
              onChange: (v) {
                Provider.of<EditProductProvider>(context, listen: false)
                    .details = v;
              },
              label: 'التفاصيل',
            ),
            SizedBox(height: 20),
            RegisterTextField(
              label: 'الكمية',
              type: TextInputType.number,
              init: widget.shopProduct.available.toString(),
              onChange: (v) {
                Provider.of<EditProductProvider>(context, listen: false)
                    .available = v;
              },
            ),
            SizedBox(height: 20),
            RegisterTextField(
              label: 'السعر',
              type: TextInputType.number,
              init: widget.shopProduct.price,
              onChange: (v) {
                Provider.of<EditProductProvider>(context, listen: false).price =
                    v;
              },
            ),
            SizedBox(height: 20),

            //  (_img.length < 1) == true
            //                 ? Container()
            //                 :
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height: 120,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.shopProduct.photos.length,
                  itemBuilder: (context, index) {
                    return _oneImgNetwork(
                        widget.shopProduct.photos[index].photo,
                        index,
                        widget.shopProduct.photos[index].id);
                  },
                ),
              ),
            ),
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
                        (_img.length < 1) == true
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
                    border:
                        Border.all(color: Color.fromRGBO(220, 220, 220, 1))),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SignInButton(
                textSize: 15,
                btnWidth: MediaQuery.of(context).size.width - 20,
                btnHeight: 45,
                onPressSignIn: () {
                  setState(() {
                    autoError = true;
                  });
                  final isValid = _form.currentState.validate();
                  if (!isValid) {
                    return;
                  }
                  _form.currentState.save();
                  Provider.of<EditProductProvider>(context, listen: false)
                      .photos = filesAsset;
                  Provider.of<EditProductProvider>(context, listen: false)
                      .imgs = _img;
                  Provider.of<EditProductProvider>(context, listen: false)
                      .createProduct(
                          Provider.of<SharedPref>(context, listen: false).token,
                          widget.shopProduct.id,
                          context);
                },
                txtColor: Colors.white,
                btnColor: Theme.of(context).primaryColor,
                buttonText: "تعديل",
              ),
            ),
          ],
        ),
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
                  if (widget.shopProduct.photos.length == 1) {
                    CustomAlert()
                        .toast(context: context, title: "لا يمكن الحذف");
                  } else {
                    widget.shopProduct.photos.removeAt(index);
                    Provider.of<DeletePhotoProvider>(context, listen: false)
                        .deletNot(
                            Provider.of<SharedPref>(context, listen: false)
                                .token,
                            id,
                            context);
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
