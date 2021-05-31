import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/termsProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsApp extends StatefulWidget {
  @override
  _TermsAppState createState() => _TermsAppState();
}

class _TermsAppState extends State<TermsApp> {
  _launchURL() async {
    const url = 'https://tqnee.com.sa';
    launch(url);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<TermsProvider>(context, listen: false).getTerms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: defaultAppBar(
        context: context,
        title: "الشروط والاحكام",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: Provider.of<TermsProvider>(
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
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 20, top: 8),
                          child: Html(
                            data:
                                "${Provider.of<TermsProvider>(context, listen: false).content}",
                            // padding: EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: InkWell(
                      onTap: _launchURL,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'تصميم وتنفيذ تقني لتقنية المعملومات',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 12),
                          )),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
