import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/internal/widget/CompleteOrderCard.dart';
import 'package:shobek/src/MainScreens/driver/widgets/total_card.dart';
import 'package:shobek/src/MainWidgets/app_empty.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/ClientOrderProvider.dart';

class CompleteOrders extends StatefulWidget {
  @override
  _CompleteOrdersState createState() => _CompleteOrdersState();
}

class _CompleteOrdersState extends State<CompleteOrders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "مدفوعاتي",
            hasBack: true,
            onPress: () => Navigator.pop(context),
          ),
          body: FutureBuilder(
              future: Provider.of<ClientOrdersProvider>(context, listen: false)
                  .getClientOrders(
                      
                      2,
                      context),
              builder: (c, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return AppLoader();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else {
                      double total = 0;
                      if (snapshot.data.data != null)
                        for (int i = 0; i < snapshot.data.data.length; i++) {
                          total += double.parse(
                                  snapshot.data.data[i].orderPrice ?? 0) +
                              double.parse(snapshot.data.data[i].price ?? "0");
                        }
                      return snapshot.data.data == null ||
                              snapshot.data.data.length == 0
                          ? Center(
                              child: AppEmpty(
                                text: "لا يوجد مدفوعات",
                              ),
                            )
                          : ListView(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.data.length,
                                      itemBuilder: (c, index) => CompleteOrder(
                                            driverCommitions:
                                                snapshot.data.data[index],
                                          )),
                                ),
                                TotalCard(
                                  total: "$total",
                                  title: 'إجمالي العمولات المدفوعة',
                                )
                              ],
                            );
                    }
                }
              }),
        ));
  }
}
