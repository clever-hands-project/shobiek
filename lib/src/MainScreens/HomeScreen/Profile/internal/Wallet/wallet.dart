import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/myChargeProvider.dart';
import 'package:shobek/src/Provider/walletRequstProvider.dart';
import 'widget/chargeScreen.dart';

class MyWallet extends StatefulWidget {
  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "محفظتي",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          FutureBuilder(
              future: Provider.of<MyChargeProvider>(context, listen: false)
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
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${snapshot.data.data.length == 0 ? 0 : snapshot.data.data[0].value ?? 0}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 40),
                              ),
                              Text(
                                "الرصيد",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                }
              }),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (c) => ChargeScreen())),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "اشحن محفظتك",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.credit_card,
                            color: Theme.of(context).primaryColor,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Provider.of<WalletRequestProvider>(context,
                      listen: false)
                  .walletRequest(context,
                      Provider.of<SharedPref>(context, listen: false).token),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "سحب الرصيد",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.credit_card,
                            color: Theme.of(context).primaryColor,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
