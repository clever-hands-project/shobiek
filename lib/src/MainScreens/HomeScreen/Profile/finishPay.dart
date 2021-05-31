import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/userPayProvider.dart';

class FinishPay extends StatefulWidget {
  final int orderID;

  const FinishPay({Key key, this.orderID}) : super(key: key);
  @override
  _FinishPayState createState() => _FinishPayState();
}

class _FinishPayState extends State<FinishPay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("طريقة الدفع"),
      //   centerTitle: true,
      //   leading: InkWell(
      //     onTap: () => Navigator.pop(context),
      //     child: Icon(Icons.arrow_back_ios),
      //   ),
      // ),
      appBar: defaultAppBar(
        context: context,
        title: "طريقة الدفع",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          Lottie.network(
            'https://assets2.lottiefiles.com/packages/lf20_VP2AtQ.json',
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // InkWell(
              //   onTap: () {
              //     Provider.of<UserPayProvider>(context, listen: false)
              //         .userPay(widget.orderID, "4", context)
              //         .then((v) {
              //       if (v == true) {
              //         Navigator.pop(context);
              //       }
              //     });
              //   },
              //   child: Column(
              //     children: [
              //       Lottie.network(
              //           'https://assets2.lottiefiles.com/temp/lf20_7wBmmb.json',
              //           width: 50,
              //           height: 50),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       Text("محفظة")
              //     ],
              //   ),
              // ),
              InkWell(
                onTap: () {
                  onlinePay();
                },
                child: Column(
                  children: [
                    Lottie.network(
                        'https://assets2.lottiefiles.com/packages/lf20_g3ki3g0v.json',
                        width: 100,
                        height: 100),
                    Text("اختر طريقة الدفع")
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  onlinePay() {
    showModalBottomSheet(
        backgroundColor: Colors.black12,
        context: context,
        builder: (_) {
          return Container(
            height: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                ),
                color: Colors.white),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(FontAwesomeIcons.ccVisa),
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text("فيزا - ماستر")),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Provider.of<UserPayProvider>(context, listen: false)
                              .userPay(widget.orderID, "2", context);
                        },
                      ),
                    ),
                    Divider(
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(FontAwesomeIcons.creditCard),
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text("بطاقة مدى")),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Provider.of<UserPayProvider>(context, listen: false)
                              .userPay(widget.orderID, "1", context);
                        },
                      ),
                    ),
                    Divider(
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                  ],
                ),
                Platform.isAndroid
                    ? Container()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(FontAwesomeIcons.applePay),
                                  Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text("apple pay")),
                                ],
                              ),
                              onPressed: () {
                                Provider.of<UserPayProvider>(context,
                                        listen: false)
                                    .userPay(widget.orderID, "3", context);
                              },
                            ),
                          ),
                          Divider(
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                        ],
                      ),
              ],
            ),
          );
        });
  }
}
