import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/orderItem.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/app_login.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Models/ClientOrderModel.dart';
import 'package:shobek/src/Provider/ClientOrderProvider.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'activeOrder.dart';

class OrderScreen extends StatefulWidget {
  final Function onBack;

  const OrderScreen({Key key, this.onBack}) : super(key: key);
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController controller = new TextEditingController();
  bool isActive = true; // true = طلبات نشطة , false = طلبات مكتملة

  @override
  void initState() {
    Provider.of<ClientOrdersProvider>(context, listen: false)
        .getClientOrders(1, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "طلباتي",
        hasBack: false,
        onPress: widget.onBack,
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
                            Provider.of<ClientOrdersProvider>(context,
                                    listen: false)
                                .getClientOrders(1, context);
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
                            Provider.of<ClientOrdersProvider>(context,
                                    listen: false)
                                .getClientOrders(2, context);
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
                      ? FutureBuilder<ClientOrderModle>(
                          future: Provider.of<ClientOrdersProvider>(context,
                                  listen: false)
                              .getClientOrders(1, context),
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
                                          itemBuilder: (c, i) => OrderItem(
                                            image: snapshot
                                                .data.data[i].driverPhoto,
                                            productName:
                                                snapshot.data.data[i].driver,
                                            productId: snapshot.data.data[i].id
                                                .toString(),
                                            price: snapshot.data.data[i].price,
                                            shopName:
                                                snapshot.data.data[i].shop,
                                            description: snapshot
                                                .data.data[i].orderTime
                                                .toString()
                                                .substring(0, 10),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ActiveOrder(clientOrderModle: snapshot.data.data[i],),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                            }
                          })
                      : FutureBuilder(
                          future: Provider.of<ClientOrdersProvider>(context,
                                  listen: false)
                              .getClientOrders(2, context),
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
                                          itemBuilder: (c, i) => OrderItem(
                                            image: snapshot
                                                .data.data[i].driverPhoto,
                                            productName:
                                                snapshot.data.data[i].driver,
                                            productId: snapshot.data.data[i].id
                                                .toString(),
                                            price: snapshot.data.data[i].price,
                                            shopName:
                                                snapshot.data.data[i].shop,
                                            description: snapshot
                                                .data.data[i].orderTime
                                                .toString()
                                                .substring(0, 10),
                                            onTap: () {
                                              // Navigator.of(context).push(
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         WaitingOrder(),
                                              //   ),
                                              // );
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
