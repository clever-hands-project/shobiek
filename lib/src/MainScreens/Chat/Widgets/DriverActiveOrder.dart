import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/clientItem.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/orderItem.dart';
import 'package:shobek/src/MainScreens/driver/widgets/shopItemCard.dart';
import 'package:shobek/src/MainWidgets/custom_bottom_sheet.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Models/DriverModel/DriverOrderModle.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverActiveOrder extends StatefulWidget {
  final DriverOrder driverOrderModle;

  const DriverActiveOrder({Key key, this.driverOrderModle}) : super(key: key);

  @override
  _DriverActiveOrderState createState() => _DriverActiveOrderState();
}

class _DriverActiveOrderState extends State<DriverActiveOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "تفاصيل الطلب",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: Directionality(
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
                  productName:
                      widget.driverOrderModle.productsCart[index].productName ??
                          "اسم المنتج بالتفصيل",
                  productId: widget.driverOrderModle.productsCart[index].id
                          .toString() ??
                      "1654654",
                  price:
                      widget.driverOrderModle.productsCart[index].price ?? "88",
                  shopName:
                      widget.driverOrderModle.productsCart[index].shopName ??
                          "اسم المتجر",
                  description: "عدد: 4قطع",
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

                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => MessageScreen(),
                //   ),
                // );
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
                          Text(
                            "التوصيل: " + widget.driverOrderModle.price + " SR",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
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
          ],
        ),
      ),
    );
  }
}
