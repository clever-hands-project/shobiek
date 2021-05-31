import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/app_login.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/ClientOrderProvider.dart';
import 'package:shobek/src/Provider/DriverProvider/DriverOrderProvider.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

import 'widgets/driverEndOrder.dart';
import 'widgets/driverNewOrder.dart';
import 'widgets/driverOrderItem.dart';

class DriverOrders extends StatefulWidget {
  final Function onBack;

  const DriverOrders({Key key, this.onBack}) : super(key: key);
  @override
  _DriverOrdersState createState() => _DriverOrdersState();
}

class _DriverOrdersState extends State<DriverOrders> {
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
        hasBack: true,
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
                        text: "طلبات جديدة",
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
                      ? FutureBuilder(
                          future: Provider.of<DriverOrdersProvider>(context,
                                  listen: false)
                              .getDriverOrders(
                                  Provider.of<SharedPref>(context,
                                          listen: false)
                                      .token,
                                  "0",
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
                                          itemBuilder: (c, index) =>
                                              DriverOrderItem(
                                            image: snapshot
                                                .data.data[index].shopPhoto,
                                            productName: snapshot
                                                    .data.data[index].shop ??
                                                "اسم المنتج بالتفصيل",
                                            productId: snapshot
                                                    .data.data[index].id
                                                    .toString() ??
                                                "1654654",
                                            price: snapshot.data.data[index]
                                                    .totalPrice ??
                                                "88",
                                            shopName: snapshot.data.data[index]
                                                    .orderDetails ??
                                                "اسم المتجر",
                                            description: snapshot
                                                    .data.data[index].createdAt
                                                    .toString()
                                                    .substring(0, 11) ??
                                                "28/12/2021",
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DriverNewOrder(
                                                    driverOrderModle: snapshot
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
                          future: Provider.of<DriverOrdersProvider>(context,
                                  listen: false)
                              .getDriverOrders(
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
                                          itemBuilder: (c, index) =>
                                              DriverOrderItem(
                                            image: snapshot
                                                .data.data[index].shopPhoto,
                                            productName: snapshot
                                                    .data.data[index].shop ??
                                                "اسم المنتج بالتفصيل",
                                            productId: snapshot
                                                    .data.data[index].id
                                                    .toString() ??
                                                "1654654",
                                            price: snapshot.data.data[index]
                                                    .totalPrice ??
                                                "88",
                                            shopName: snapshot.data.data[index]
                                                    .orderDetails ??
                                                "اسم المتجر",
                                            description: snapshot
                                                    .data.data[index].createdAt
                                                    .toString()
                                                    .substring(0, 11) ??
                                                "28/12/2020",
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DriverEndOrder(
                                                    driverOrderModle: snapshot
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
