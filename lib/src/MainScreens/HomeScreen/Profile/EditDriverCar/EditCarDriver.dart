// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shobek/src/Helpers/Widgets/ImagePicker/image_picker_handler.dart';
// import 'package:shobek/src/MainWidgets/customBtn.dart';

// import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
// import 'package:shobek/src/MainWidgets/networkImage.dart';

// import 'package:shobek/src/Models/auth/AuthModle.dart';
// import 'package:shobek/src/Provider/auth/AuthController.dart';
// import 'package:shobek/src/Repository/appLocalization.dart';

// class EditCarPage extends StatefulWidget {
//   @override
//   _EditCarPageState createState() => _EditCarPageState();
// }

// class _EditCarPageState extends State<EditCarPage>
//     with TickerProviderStateMixin, ImagePickerListener {
//   ImagePickerHandler imagePicker;
//   AnimationController _controller;

//   String name;

//   @override
//   userImage(File _image) {
  
//     setState(() {
//     });
//   }

//   @override
//   void initState() {
//     _controller = new AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     imagePicker = new ImagePickerHandler(
//         this, _controller, Color.fromRGBO(12, 169, 149, 1));
//     imagePicker.init();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     UserData userData =
//         Provider.of<AuthController>(context, listen: true).userModel.data;
//     return Scaffold(
//       appBar: defaultAppBar(
//         context: context,
//         title: localization.text("edit_car"),
//         hasBack: true,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: [
//           editDriverData(
//             userData.identity,
//             "هوية السائق",
//             () => imagePicker.showDialog(context),
//           ),
//           editDriverData(userData.license, "رخصة السائق", () {}),
//           editDriverData(userData.carForm, "رخصة السيارة", () {}),
//           CustomBtn(
//             txtColor: Colors.black,
//             heigh: 50,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             onTap: () {
//               // userController.editUserData(context, name: name);
//               print("please fill oldPassword Field");
//             },
//             color: Theme.of(context).primaryColor,
//             text: 'حفظ',
//           ),
//         ],
//       ),
//     );
//   }

//   editDriverData(String photo, String title, Function onEdit) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       height: 200,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Theme.of(context).accentColor,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             alignment: Alignment.center,
//             height: 50,
//             child: Row(
//               children: [
//                 Expanded(flex: 1, child: SizedBox()),
//                 Expanded(
//                   flex: 10,
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 Expanded(
//                     flex: 1,
//                     child: IconButton(
//                       onPressed: onEdit,
//                       icon: Icon(
//                         Icons.edit,
//                         color: Colors.white,
//                       ),
//                     )),
//               ],
//             ),
//           ),
//           Container(
//             height: 150,
//             width: double.infinity,
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(15),
//                 bottomRight: Radius.circular(15),
//               ),
//               child: networkImage(photo),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
