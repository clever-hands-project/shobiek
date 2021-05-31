import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainScreens/driver/driverMainPage.dart';
import 'package:shobek/src/MainScreens/mainPage.dart';
import 'package:shobek/src/MainScreens/shop/ShopMainPage.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnlinePaymentScreen extends StatefulWidget {
  final String url;

  const OnlinePaymentScreen({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _OnlinePaymentScreenState createState() => _OnlinePaymentScreenState();
}

class _OnlinePaymentScreenState extends State<OnlinePaymentScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     "اتمام عملية الدفع",
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   centerTitle: true,
        //   leading: InkWell(
        //     onTap: () => Navigator.pop(context),
        //     child: Icon(
        //       Icons.arrow_back_ios,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        appBar: defaultAppBar(
          context: context,
          title: "اتمام عملية الدفع",
          hasBack: true,
          onPress: () => Navigator.pop(context),
        ),
        body: Stack(
          children: <Widget>[
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              debuggingEnabled: true,
              onPageFinished: (finish) {
                if (finish.contains("fatoora/success")) {
                  print("done");
                  Provider.of<AuthController>(context, listen: false)
                              .userModel
                              .data
                              .type ==
                          1
                      ? Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => MainPage(
                                    index: 2,
                                  )),
                          (Route<dynamic> route) => false)
                      : Provider.of<AuthController>(context, listen: false)
                                  .userModel
                                  .data
                                  .type ==
                              2
                          ? Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => DriverMainPage(
                                      // index: 1,
                                      )),
                              (Route<dynamic> route) => false)
                          : Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => ShopMainPage(
                                      // index: 1,
                                      )),
                              (Route<dynamic> route) => false);
                } else {
                  Future.delayed(Duration(seconds: 2), () {
                    setState(() {
                      isLoading = false;
                    });
                  });
                }
              },
              onPageStarted: (start) {
                setState(() {
                  isLoading = true;
                });
              },
            ),
            isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.network(
                              "https://assets10.lottiefiles.com/packages/lf20_x62chJ.json",
                              height: MediaQuery.of(context).size.height / 1.4,
                            ),
                            Text("جاري معالجة البيانات.."),
                          ],
                        ),
                      ],
                    ),
                  )
                : Stack(),
          ],
        ),
      );
    });
  }
}
