import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/aboutUsProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  _launchURL() async {
    const url = 'https://tqnee.com.sa';
    launch(url);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AboutUsProvider>(context, listen: false).getAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: defaultAppBar(
        context: context,
        title: "عن التطبيق",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: Provider.of<AboutUsProvider>(
                context,
              ).content ==
              null
          ? AppLoader()
          : Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40.0,
                  ),
                  child: ListView(
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Html(
                            data:
                                "${Provider.of<AboutUsProvider>(context, listen: false).content}",
                            // padding: EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     color: Colors.white,
                //     child: InkWell(
                //       onTap: _launchURL,
                //       child: Padding(
                //           padding: EdgeInsets.all(10),
                //           child: Text(
                //             'تصميم وتنفيذ تقني لتقنية المعملومات',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //                 color: Colors.blueAccent, fontSize: 12),
                //           )),
                //     ),
                //   ),
                // ),
              ],
            ),
    );
  }
}
