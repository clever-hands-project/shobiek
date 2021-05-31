import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/internal/getLocation.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Provider/get/MyAddressProvider.dart';
import 'package:shobek/src/Provider/post/post_current_order_provider.dart';
import 'package:shobek/src/MainWidgets/details_text_field_no_img%20copy.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';

class FinishOrder extends StatefulWidget {
  const FinishOrder({
    Key key,
  }) : super(key: key);
  @override
  _FinishOrderState createState() => _FinishOrderState();
}

class _FinishOrderState extends State<FinishOrder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Provider.of<MyAddressProvider>(context, listen: false).getPlaces();
    super.initState();
    Provider.of<PostCurrentOrderProvider>(context, listen: false).lat =
        Provider.of<AuthController>(context, listen: false).lat.toString();
    Provider.of<PostCurrentOrderProvider>(context, listen: false).long =
        Provider.of<AuthController>(context, listen: false).long.toString();
  }

  bool location = false;
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
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Material(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: location ? Colors.green : Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                            MaterialPageRoute(builder: (c) => GetLocation()))
                        .then((v) {
                      if (v) {
                        setState(() {
                          location = true;
                        });
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Material(
                          color: Colors.white,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(Icons.location_on,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Container(
                              width: 1, height: 20, color: Colors.grey),
                        ),
                        Text(Provider.of<PostCurrentOrderProvider>(context,
                                        listen: false)
                                    .arrivalDetails !=
                                null
                            ? Provider.of<PostCurrentOrderProvider>(context,
                                    listen: false)
                                .arrivalDetails
                            : 'وين نوصل طلبك'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          Material(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: location ? Colors.green : Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: DetailsTextFieldNoImg(
                    label: 'تفاصيل الطلب',
                    onChange: (v) {
                      Provider.of<PostCurrentOrderProvider>(context,
                              listen: false)
                          .orderDrtails = v;
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
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
                } else if (Provider.of<PostCurrentOrderProvider>(context,
                            listen: false)
                        .orderDrtails ==
                    null) {
                  CustomAlert().toast(
                    context: context,
                    title: "يجب كتابة تفاصيل للطلب",
                  );
                  return;
                }
                print(Provider.of<PostCurrentOrderProvider>(context,
                        listen: false)
                    .arrivalDetails);
                print(Provider.of<PostCurrentOrderProvider>(context,
                        listen: false)
                    .orderDrtails);

                Provider.of<PostCurrentOrderProvider>(context, listen: false)
                    .postCart(context);
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
