import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/orderItem.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/app_login.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/shop/shopOrdersProvider.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'Orders/ShopActiveOrder.dart';
import 'Orders/ShopEndOrder.dart';

class ShopOrderScreen extends StatefulWidget {
  final Function onBack;

  const ShopOrderScreen({Key key, this.onBack}) : super(key: key);
  @override
  _ShopOrderScreenState createState() => _ShopOrderScreenState();
}

class _ShopOrderScreenState extends State<ShopOrderScreen> {
  TextEditingController controller = new TextEditingController();
  bool isActive = true; // true = طلبات نشطة , false = طلبات مكتملة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "طلباتي",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            // Order Buttons
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    // Active Orders
                    Expanded(
                      flex: 1,
                      child: CustomBtn(
                        heigh: 50,
                        color: isActive
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        text: "طلبات نشطة",
                        onTap: () {
                          setState(() {
                            Provider.of<ShopOrderProvider>(context,
                                    listen: false)
                                .getShopOrders(
                                    Provider.of<SharedPref>(context,
                                            listen: false)
                                        .token,
                                    "1",
                                    context);
                            if (isActive == false) isActive = true;
                          });
                        },
                      ),
                    ),
                    // Completed Orders
                    Expanded(
                      flex: 1,
                      child: CustomBtn(
                        heigh: 50,
                        color: !isActive
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        text: "طلبات مكتملة",
                        onTap: () {
                          setState(() {
                            Provider.of<ShopOrderProvider>(context,
                                    listen: false)
                                .getShopOrders(
                                    Provider.of<SharedPref>(context,
                                            listen: false)
                                        .token,
                                    "2",
                                    context);
                            if (isActive == true) isActive = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Order List
            Expanded(
              flex: 9,
              child: NetworkUtil.token == null
                  ? AppShouldLogin(
                      text: "يرجي تسجيل الدخول اولا.",
                    )
                  : isActive
                      ? FutureBuilder(
                          future: Provider.of<ShopOrderProvider>(context,
                                  listen: false)
                              .getShopOrders(
                                  Provider.of<SharedPref>(context,
                                          listen: false)
                                      .token,
                                  "1",
                                  context),
                          builder: (c, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return AppLoader();
                              default:
                                if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                                else
                                  return snapshot.data.data == null
                                      ? Center(
                                          child: Text("لا يوجد طلبات"),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.data.length,
                                          itemBuilder: (c, index) => OrderItem(
                                            image: snapshot
                                                .data.data[index].userPhoto,
                                            productName: snapshot
                                                .data.data[index].orderDetails,
                                            productId: snapshot
                                                .data.data[index].id
                                                .toString(),
                                            price: snapshot
                                                .data.data[index].totalPrice,
                                            shopName:
                                                snapshot.data.data[index].user,
                                            dismissible: false,
                                            description: snapshot
                                                .data.data[index].createdAt
                                                .toString()
                                                .substring(0, 11),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShopActiveOrder(
                                                    shopOrder: snapshot
                                                        .data.data[index],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                            }
                          })
                      : FutureBuilder(
                          future: Provider.of<ShopOrderProvider>(context,
                                  listen: false)
                              .getShopOrders(
                                  Provider.of<SharedPref>(context,
                                          listen: false)
                                      .token,
                                  "2",
                                  context),
                          builder: (c, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return AppLoader();
                              default:
                                if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                                else
                                  return snapshot.data.data == null
                                      ? Center(
                                          child: Text("لا يوجد طلبات"),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.data.length,
                                          itemBuilder: (c, index) => OrderItem(
                                            image: snapshot
                                                .data.data[index].userPhoto,
                                            productName: snapshot.data
                                                    .data[index].orderDetails ??
                                                "",
                                            productId: snapshot
                                                .data.data[index].id
                                                .toString(),
                                            price: snapshot
                                                .data.data[index].totalPrice,
                                            shopName:
                                                snapshot.data.data[index].user,
                                            description: snapshot
                                                .data.data[index].createdAt
                                                .toString()
                                                .substring(0, 11),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShopEndOrder(
                                                    shopOrder: snapshot
                                                        .data.data[index],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                            }
                          }),
            ),
          ],
        ),
      ),
    );
  }
}
