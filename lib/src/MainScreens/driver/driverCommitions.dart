import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Models/DriverModel/driverComisstionModle.dart';
import 'package:shobek/src/Provider/DriverProvider/driverCommitionProvider.dart';

import 'widgets/driverCommitionCard.dart';
import 'widgets/total_card.dart';

class Commitions extends StatefulWidget {
  final String url;

  const Commitions({Key key, this.url}) : super(key: key);
  @override
  _CommitionsState createState() => _CommitionsState();
}

class _CommitionsState extends State<Commitions> {
  bool isActive = true; // true = طلبات نشطة , false = طلبات مكتملة

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "عمولاتي",
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
                            text: "عمولات مدفوعة",
                            onTap: () {
                              setState(() {
                                Provider.of<DriverCommitionsProvider>(context,
                                        listen: false)
                                    .getDriverCommitions(
                                        Provider.of<SharedPref>(context,
                                                listen: false)
                                            .token,
                                        widget.url,
                                        "0",
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
                            text: "عمولات مستحقة",
                            onTap: () {
                              setState(() {
                                Provider.of<DriverCommitionsProvider>(context,
                                        listen: false)
                                    .getDriverCommitions(
                                        Provider.of<SharedPref>(context,
                                                listen: false)
                                            .token,
                                        widget.url,
                                        "1",
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
                    child: isActive
                        ? FutureBuilder(
                            future: Provider.of<DriverCommitionsProvider>(
                                    context,
                                    listen: false)
                                .getDriverCommitions(
                                    Provider.of<SharedPref>(context,
                                            listen: false)
                                        .token,
                                    widget.url,
                                    "0",
                                    context),
                            builder: (c, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return AppLoader();
                                default:
                                  if (snapshot.hasError)
                                    return Text('Error: ${snapshot.error}');
                                  else {
                                    List<Commission> filteromision = [];
                                    if (snapshot.data.data != null) {
                                      for (int i = 0;
                                          i <
                                              snapshot.data.data[0].commissions
                                                  .length;
                                          i++) {
                                        if (snapshot.data.data[0].commissions[i]
                                                .commissionStatus ==
                                            1) {
                                          // setState(() {
                                            filteromision.add(snapshot
                                              .data.data[0].commissions[i]);
                                          // });
                                           print("filteromision 1");
                                        }
                                      }
                                    }
                                    return snapshot.data.data == null
                                        ? Center(
                                            child: Text("لا يوجد عمولات"),
                                          )
                                        : ListView(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.5,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        filteromision.length,
                                                    itemBuilder: (c, index) =>
                                                        DriverCommitionCard(
                                                          driverCommitions:
                                                              filteromision[
                                                                  index],
                                                        )),
                                              ),
                                              TotalCard(
                                                total: snapshot.data.data[0]
                                                    .totalPaidCommissions,
                                                title:
                                                    'إجمالي العمولات المدفوعة',
                                              )
                                            ],
                                          );
                                  }
                              }
                            })
                        : FutureBuilder(
                            future:
                                Provider.of<DriverCommitionsProvider>(context,
                                        listen: false)
                                    .getDriverCommitions(
                                        Provider.of<SharedPref>(context,
                                                listen: false)
                                            .token,
                                        widget.url,
                                        "1",
                                        context),
                            builder: (c, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return AppLoader();
                                default:
                                  if (snapshot.hasError)
                                    return Text('Error: ${snapshot.error}');
                                  else {
                                    List<Commission> filteromision = [];
                                    if (snapshot.data.data != null) {
                                      for (int i = 0;
                                          i <
                                              snapshot.data.data[0].commissions
                                                  .length;
                                          i++) {
                                        if (snapshot.data.data[0].commissions[i]
                                                .commissionStatus ==
                                            0) {
                                          // setState(() {
                                            print("filteromision 0");
                                            filteromision.add(snapshot
                                              .data.data[0].commissions[i]);
                                          // });
                                        }
                                      }
                                    }
                                    return snapshot.data.data == null
                                        ? Center(
                                            child: Text("لا يوجد عمولات"),
                                          )
                                        : ListView(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.5,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        filteromision.length,
                                                    itemBuilder: (c, index) =>
                                                        DriverCommitionCard(
                                                          driverCommitions:
                                                              filteromision[
                                                                  index],
                                                        )),
                                              ),
                                              TotalCard(
                                                total: snapshot.data.data[0]
                                                        .totalUnpaidCommissions ??
                                                    "0",
                                                title:
                                                    'إجمالي العمولات المستحقة',
                                              )
                                            ],
                                          );
                                  }
                              }
                            })),
              ],
            ),
          ),
        ));
  }
}
