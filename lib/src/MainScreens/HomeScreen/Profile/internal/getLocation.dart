import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/labeled_bottom_sheet_map.dart';
import 'package:shobek/src/MainWidgets/mapCard.dart';
import 'package:shobek/src/Provider/get/MyAddressProvider.dart';
import 'package:shobek/src/Provider/post/post_current_order_provider.dart';

class GetLocation extends StatefulWidget {
  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<MyAddressProvider>(context, listen: false).getPlaces();
    super.initState();
  }

  bool location = false;
  bool chosesMyLocation = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: defaultAppBar(
        context: context,
        title: "السلة",
        hasBack: true,
        onPress: () {
          Navigator.of(context).pop();
        },
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),
          Visibility(
            visible: Provider.of<MyAddressProvider>(context, listen: true)
                    .placesSheet
                    .length >
                0,
            child: LabeledBottomSheetMap(
              label: '-- عناويني --',
              onChange: (v) {
                setState(() {
                  chosesMyLocation = true;
                  location = true;
                });

                Provider.of<PostCurrentOrderProvider>(context, listen: false)
                    .lat = v.lat.toString();
                Provider.of<PostCurrentOrderProvider>(context, listen: false)
                    .long = v.long.toString();
                Provider.of<PostCurrentOrderProvider>(context, listen: false)
                    .arrivalDetails = v.addressDetails.toString();
              },
              data: Provider.of<MyAddressProvider>(context, listen: true)
                  .placesSheet,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: !chosesMyLocation,
            child: MapCard(
              scaffoldKey: _scaffoldKey,
              onTap: () {
                setState(() {
                  location = true;
                });
                Navigator.pop(context);
              },
              withAppBar: true,
              onChange: (v) {
                Provider.of<PostCurrentOrderProvider>(context, listen: false)
                    .lat = v.latitude.toString();
                Provider.of<PostCurrentOrderProvider>(context, listen: false)
                    .long = v.longitude.toString();
              },
              onTextChange: (v) {
                Provider.of<PostCurrentOrderProvider>(context, listen: false)
                    .arrivalDetails = v;
              },
              //  lable: "وين نوصل طلبك",
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomBtn(
              color: Theme.of(context).accentColor,
              onTap: () {
                if (location == false) {
                  CustomAlert().toast(
                    context: context,
                    title: "يجب تحديد موقع طلبك",
                  );
                  return;
                }
                Navigator.pop(context, true);
              },
              text: 'تأكيد الطلب',
              txtColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
