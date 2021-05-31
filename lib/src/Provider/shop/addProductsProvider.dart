// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CreateProduct extends StatefulWidget {
//   @override
//   _CreateProductState createState() => _CreateProductState();
// }

// class _CreateProductState extends State<CreateProduct> {
//   GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     Provider.of<ProductCategoryProvider>(context, listen: false)
//         .getServicesCatogory(context);
//     Future.delayed(Duration(microseconds: 150), () {
//       Provider.of<CreateProductProvider>(context, listen: false).setNull();
//     });

//     super.initState();
//   }

//   final _form = GlobalKey<FormState>();
//   bool autoError = false;
//   List<File> _img = [];
//   List<Asset> files = [];
//   List<Asset> filesAsset = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _globalKey,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50),
//         child: CustomAppBar(
//           onTap: () => Navigator.pop(context),
//           label: "اضافة منتج جديد",
//           iconData: Icons.arrow_back_ios,
//         ),
//       ),
//       body: Provider.of<SharedPref>(context, listen: false).token == null
//           ? Center(
//               child: Row(
//               textDirection: TextDirection.rtl,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Text(
//                   "لمشاهدة الاشعارات يرجي التسجيل اولا",
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (c) => SignInScreen()));
//                   },
//                   child: Text(
//                     "تسجيل الدخول",
//                     style: TextStyle(
//                         color: Colors.blue, fontWeight: FontWeight.bold),
//                   ),
//                 )
//               ],
//             ))
//           : Form(
//               key: _form,
//               autovalidateMode: autoError
//                   ? AutovalidateMode.always
//                   : AutovalidateMode.disabled,
//               child: ListView(
//                 children: <Widget>[
//                   SizedBox(height: 20),
//                   RegisterTextField(
//                     label: ' اسم المنتج',
//                     hint: "يكتب هنا اسم المنتج",
//                     type: TextInputType.text,
//                     onChange: (v) {
//                       Provider.of<CreateProductProvider>(context, listen: false)
//                           .placeName = v;
//                     },
//                   ),
//                   LabeledBottomSheet(
//                       label: '-- القسم التابع له --',
//                       onChange: (v) {
//                         Provider.of<CreateProductProvider>(context,
//                                 listen: false)
//                             .categoryId = v.id.toString();
//                       },
//                       data: Provider.of<ProductCategoryProvider>(context,
//                               listen: true)
//                           .bottomSheet),
//                   SizedBox(height: 20),
//                   DetailsTextFieldNoImg(
//                     hint: 'يكتب هنا التفاصيل العامة ',
//                     onChange: (v) {
//                       Provider.of<CreateProductProvider>(context, listen: false)
//                           .details = v;
//                     },
//                     label: 'التفاصيل',
//                   ),
//                   SizedBox(height: 20),
//                   RegisterTextField(
//                     label: 'الكمية',
//                     type: TextInputType.number,
//                     onChange: (v) {
//                       Provider.of<CreateProductProvider>(context, listen: false)
//                           .available = v;
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   RegisterTextField(
//                     label: 'السعر',
//                     type: TextInputType.number,
//                     onChange: (v) {
//                       Provider.of<CreateProductProvider>(context, listen: false)
//                           .price = v;
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   _img.length != 0 || filesAsset.length != 0
//                       ? Container(
//                           height: 150,
//                           child: ListView(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.horizontal,
//                             children: [
//                               (filesAsset.length < 1) == true
//                                   ? Container()
//                                   : Directionality(
//                                       textDirection: TextDirection.rtl,
//                                       child: Container(
//                                         height: 120,
//                                         child: ListView.builder(
//                                           shrinkWrap: true,
//                                           scrollDirection: Axis.horizontal,
//                                           itemCount: filesAsset.length,
//                                           itemBuilder: (context, index) {
//                                             return _oneImgFileAsset(
//                                                 filesAsset[index], index);
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                               (_img.length < 1) == true
//                                   ? Container()
//                                   : Directionality(
//                                       textDirection: TextDirection.rtl,
//                                       child: Container(
//                                         height: 120,
//                                         child: ListView.builder(
//                                           shrinkWrap: true,
//                                           scrollDirection: Axis.horizontal,
//                                           itemCount: _img.length,
//                                           itemBuilder: (context, index) {
//                                             return _oneImgFile(
//                                                 _img[index], index);
//                                           },
//                                         ),
//                                       ),
//                                     )
//                             ],
//                           ),
//                         )
//                       : Container(),
//                   SizedBox(height: 20),
//                   InkWell(
//                     onTap: () => ImagePickerDialog().show(
//                         context: context,
//                         onGet: (f, v) {
//                           if (v == 0)
//                             setState(() {
//                               filesAsset.addAll(f);
//                             });
//                           else {
//                             setState(() {
//                               _img.add(f);
//                             });
//                           }
//                           return;
//                         }),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                               color: Color.fromRGBO(220, 220, 220, 1))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Icon(Icons.photo),
//                             Text(
//                               "اضافة صورة",
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SignInButton(
//                       textSize: 15,
//                       btnWidth: MediaQuery.of(context).size.width - 20,
//                       btnHeight: 45,
//                       onPressSignIn: () {
//                         setState(() {
//                           autoError = true;
//                         });
//                         final isValid = _form.currentState.validate();
//                         if (!isValid) {
//                           return;
//                         }
//                         _form.currentState.save();
//                         Provider.of<CreateProductProvider>(context,
//                                 listen: false)
//                             .photos = filesAsset;
//                         Provider.of<CreateProductProvider>(context,
//                                 listen: false)
//                             .imgs = _img;
//                         Provider.of<CreateProductProvider>(context,
//                                 listen: false)
//                             .createProduct(
//                                 Provider.of<SharedPref>(context, listen: false)
//                                     .token,
//                                 0,
//                                 context);
//                       },
//                       txtColor: Colors.white,
//                       btnColor: Theme.of(context).primaryColor,
//                       buttonText: "اضافة",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _oneImgFileAsset(Asset img, int index) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10, left: 10),
//       child: Stack(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(top: 10, right: 10),
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: AssetThumb(
//                     asset: img,
//                     width: 300,
//                     height: 300,
//                   )),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   filesAsset.removeAt(index);
//                 });
//               },
//               child: Material(
//                 color: Colors.white,
//                 elevation: 2,
//                 shape: CircleBorder(),
//                 child: Padding(
//                   padding: EdgeInsets.all(5),
//                   child: Icon(Icons.close, size: 18),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _oneImgFile(File img, int index) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10, left: 10),
//       child: Stack(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(top: 10, right: 10),
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.file(
//                     img,
//                     // width: 300,
//                     // height: 300,
//                   )),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   _img.removeAt(index);
//                 });
//               },
//               child: Material(
//                 color: Colors.white,
//                 elevation: 2,
//                 shape: CircleBorder(),
//                 child: Padding(
//                   padding: EdgeInsets.all(5),
//                   child: Icon(Icons.close, size: 18),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
