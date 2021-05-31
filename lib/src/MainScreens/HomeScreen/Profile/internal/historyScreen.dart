import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/historyProvider.dart';

import 'Wallet/widget/history_card.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "سجل العمليات",
            hasBack: true,
            onPress: () => Navigator.pop(context),
          ),
          body: FutureBuilder(
              future: Provider.of<HistoryProvider>(context, listen: false)
                  .getHistory(
                      Provider.of<SharedPref>(context, listen: false).token,
                      "",
                      context),
              builder: (c, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return AppLoader();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else {
                      return snapshot.data.data == null
                          ? Center(
                              child: Text("لا يوجد عمليات"),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder: (c, index) => HistoryCard(
                                        history: snapshot.data.data[index],
                                      )),
                            );
                    }
                }
              }),
        ));
  }
}
