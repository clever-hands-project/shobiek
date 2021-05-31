import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/clientItem.dart';
import 'package:shobek/src/MainScreens/driver/widgets/shopItemCard.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Models/DriverModel/DriverOrderModle.dart';
import 'driverOrderItem.dart';

class DriverEndOrder extends StatelessWidget {
  final DriverOrder driverOrderModle;

  const DriverEndOrder({Key key, this.driverOrderModle}) : super(key: key);
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
                "رقم الطلب  ${driverOrderModle.id}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: driverOrderModle.productsCart.length,
              itemBuilder: (c, index) {
                return DriverOrderItem(
                  image: driverOrderModle.productsCart[index].photos[0].photo,
                  productName:
                      driverOrderModle.productsCart[index].productName ??
                          "اسم المنتج بالتفصيل",
                  productId:
                      "${driverOrderModle.productsCart[index].id.toString()}" ??
                          "1654654",
                  price: driverOrderModle.productsCart[index].price ?? "88",
                  shopName: driverOrderModle.productsCart[index].shopName ??
                      "اسم المتجر",
                  description:
                      "عدد: ${driverOrderModle.productsCart[index].quantity}قطع",
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            // Driver
            ShopItemCard(
              image: driverOrderModle.shopPhoto,
              driverName: driverOrderModle.shop,
              carType: driverOrderModle.shopPhone ?? "",
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => MessageScreen(),
                //   ),
                // );
              },
            ),
            ClientItem(
              carType: driverOrderModle.userPhone,
              clientName: driverOrderModle.user,
              image: driverOrderModle.userPhoto,
              onTap: () {},
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
                            "الطلب: " + driverOrderModle.orderPrice + " SR",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "التوصيل: " + driverOrderModle.price + " SR",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
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
                            driverOrderModle.totalPrice + " SR",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
