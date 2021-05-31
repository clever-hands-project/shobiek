import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainScreens/Chat/chat_room.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/clientItem.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/orderItem.dart';
import 'package:shobek/src/MainScreens/driver/widgets/send_offer.dart';
import 'package:shobek/src/MainScreens/driver/widgets/shopItemCard.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/custom_bottom_sheet.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Models/DriverModel/DriverOrderModle.dart';
import 'package:shobek/src/Provider/DriverProvider/DriverOrderProvider.dart';
import 'package:shobek/src/Provider/DriverProvider/driverCancelOfferProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverNewOrder extends StatefulWidget {
  final DriverOrder driverOrderModle;

  const DriverNewOrder({Key key, this.driverOrderModle}) : super(key: key);

  @override
  _DriverNewOrderState createState() => _DriverNewOrderState();
}

class _DriverNewOrderState extends State<DriverNewOrder> {
  bool sendOffer = false;

  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      Provider.of<DriverOrdersProvider>(context, listen: false)
          .getDriverOrders(
              Provider.of<SharedPref>(context, listen: false).token,
              "1",
              context)
          .then((value) {
        if (Provider.of<DriverOrdersProvider>(context, listen: false)
                .driverOrders
                .length ==
            1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => ChatRoom(
                        chateId: widget.driverOrderModle.id,
                        userName: widget.driverOrderModle.driver,
                        driverOrder: widget.driverOrderModle,
                        orderPrice: widget.driverOrderModle.orderPrice,
                        phone: widget.driverOrderModle.userPhone,
                        price: widget.driverOrderModle.price,
                      )));
          timer.cancel();
        }
      });
    });
    super.initState();
  }

  // ignore: missing_return
  Future<bool> _onBackPressed() {
    if (sendOffer == false) {
      Navigator.pop(context);
    } else
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "في حالة الخروج سيتم الغاء عرض السعر",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text("لا")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                        Provider.of<DriverCancelOfferProvider>(context,
                                listen: false)
                            .cancleOffer(widget.driverOrderModle.id, context);
                        // .then((v) {
                        // if (v == true) {
                        Navigator.pop(context, false);
                        // }
                        // });
                      },
                      child: Text("نعم"))
                ],
              ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "تفاصيل الطلب",
        hasBack: true,
        onPress: _onBackPressed,
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "رقم الطلب  ${widget.driverOrderModle.id}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.driverOrderModle.productsCart.length,
                itemBuilder: (c, index) {
                  return OrderItem(
                    image: widget.driverOrderModle.productsCart[index].photos[0]
                            .photo ??
                        "assets/images/image.jpg",
                    productName: widget
                            .driverOrderModle.productsCart[index].productName ??
                        "اسم المنتج بالتفصيل",
                    productId: widget.driverOrderModle.productsCart[index].id
                            .toString() ??
                        "1654654",
                    price: widget.driverOrderModle.productsCart[index].price ??
                        "88",
                    shopName:
                        widget.driverOrderModle.productsCart[index].shopName ??
                            "اسم المتجر",
                    description: "عدد: ${widget.driverOrderModle.productsCart[index].quantity}قطع",
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              // Driver
              ShopItemCard(
                image: widget.driverOrderModle.shopPhoto ??
                    "assets/images/image.jpg",
                driverName: widget.driverOrderModle.shop,
                carType: widget.driverOrderModle.shopPhone ?? "",
                onTap: () {
                  CustomBottomSheet().show(
                      context: context,
                      child: Container(
                        height: 200,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () async {
                                String encodedURl = Uri.encodeFull(
                                    "https://www.google.com/maps/search/?api=1&query=${widget.driverOrderModle.orderLatitude},${widget.driverOrderModle.orderLongitude}");
                                if (await canLaunch(encodedURl)) {
                                  await launch(encodedURl);
                                } else {
                                  print('Could not launch $encodedURl');
                                  throw 'Could not launch $encodedURl';
                                }
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "تحديد الموقع",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(height: 1),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                launch(
                                    "tel://${widget.driverOrderModle.shopPhone}");
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text("اتصال",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            SizedBox(height: 20)
                          ],
                        ),
                      ));
                },
              ),
              ClientItem(
                carType: widget.driverOrderModle.userPhone,
                clientName: widget.driverOrderModle.user,
                image: widget.driverOrderModle.userPhoto,
                onTap: () {
                  CustomBottomSheet().show(
                      context: context,
                      child: Container(
                        height: 200,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () async {
                                String encodedURl = Uri.encodeFull(
                                    "https://www.google.com/maps/search/?api=1&query=${widget.driverOrderModle.latitude},${widget.driverOrderModle.longitude}");
                                if (await canLaunch(encodedURl)) {
                                  await launch(encodedURl);
                                } else {
                                  print('Could not launch $encodedURl');
                                  throw 'Could not launch $encodedURl';
                                }
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "تحديد الموقع",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(height: 1),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                launch(
                                    "tel://${widget.driverOrderModle.userPhone}");
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text("اتصال",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            SizedBox(height: 20)
                          ],
                        ),
                      ));
                },
                price: "",
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              // Details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // order Price
                            Text(
                              "الطلب: " +
                                  widget.driverOrderModle.orderPrice +
                                  " SR",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "اجمالي",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 5),
                            // Total Price
                            Text(
                              widget.driverOrderModle.totalPrice + " SR",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 22,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !sendOffer,
                child: CustomBtn(
                  text: "تقديم عرض سعر ",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => SendOffer(
                                  orderID: widget.driverOrderModle.id,
                                ))).then((value) {
                      if (value == true) {
                        setState(() {
                          sendOffer = true;
                        });
                      }
                    });
                  },
                  color: Colors.black,
                  txtColor: Colors.white,
                ),
              ),
              Visibility(
                visible: sendOffer,
                child: CustomBtn(
                  text: "الغاء عرض السعر",
                  onTap: () {
                    Provider.of<DriverCancelOfferProvider>(context,
                            listen: false)
                        .cancleOffer(widget.driverOrderModle.id, context)
                        .then((v) {
                      if (v == true) {
                        setState(() {
                          sendOffer = false;
                        });
                      }
                    });
                    setState(() {
                      sendOffer = false;
                    });
                  },
                  color: Colors.red,
                  txtColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
