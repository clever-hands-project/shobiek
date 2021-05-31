import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/clientItem.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/driverItem.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/orderItem.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Models/shop/shopOrdersModle.dart';

class ShopActiveOrder extends StatelessWidget {
  final ShopOrders shopOrder;

  const ShopActiveOrder({Key key, this.shopOrder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "الطلب النشط",
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
              child: Text("رقم الطلب  ${shopOrder.id}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
            ),
            // The Active Order
            // OrderItem(
            //   image: "assets/images/image.jpg",
            //   productName: "اسم المنتج بالتفصيل",
            //   productId: "1654654",
            //   price: "88",
            //   shopName: "اسم المتجر",
            //   description: "عدد: 4قطع",
            // ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: shopOrder.productsCart.length,
              itemBuilder: (c, index) {
                return OrderItem(
                  image: "assets/images/image.jpg",
                  productName: shopOrder.productsCart[index].productName??"اسم المنتج بالتفصيل",
                  productId: shopOrder.productsCart[index].id.toString() ??"1654654",
                  price:shopOrder.productsCart[index].price?? "88",
                  shopName: shopOrder.productsCart[index].shopName??"اسم المتجر",
                   description: "عدد: ${shopOrder.productsCart[index].quantity}قطع",
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            // Driver
            DriverItem(
              image: "assets/images/image.jpg",
              driverName: shopOrder.driver,
              carType: shopOrder.driverPhone,
              onTap: () {},
             price: "سائق", 
            ),
            ClientItem(
              image: "assets/images/image.jpg",
              clientName: shopOrder.user,
              carType: shopOrder.userPhone,
              onTap: () {},
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
                            "الطلب: " + "${shopOrder.orderPrice}" + " SR",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 5),
                          // Delevery Price
                          Text(
                            "التوصيل: " + "${shopOrder.price}" + " SR",
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
                            "${shopOrder.totalPrice}" + " SR",
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
