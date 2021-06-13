import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/driverItem.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/orderItem.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Models/ClientOrderModel.dart';

class ActiveOrder extends StatelessWidget {
  final ClientOrder clientOrderModle;
  ActiveOrder({this.clientOrderModle});
  final String time = "6:00 ساعات";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "طلب النشط",
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
            // The Active Order
            OrderItem(
              image: clientOrderModle.shopPhoto,
              productName: clientOrderModle.shop,
              productId: clientOrderModle.shopId.toString(),
              price: clientOrderModle.price,
              shopName: clientOrderModle.shop,
              description:clientOrderModle.orderDetails,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            // Driver
            DriverItem(
              image: clientOrderModle.driverPhoto,
              driverName: clientOrderModle.driver,
              carType: clientOrderModle.carType==0?'عادية':'مبرده',
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => MessageScreen(),
                //   ),
                // );
              },
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
                            "الطلب: " + "55" + " SR",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 5),
                          // Delevery Price
                          Text(
                            "التوصيل: " + "20" + " SR",
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
                            "75" + " SR",
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
