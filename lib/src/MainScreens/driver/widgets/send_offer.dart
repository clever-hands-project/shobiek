import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/MainWidgets/details_text_field_no_img%20copy.dart';
import 'package:shobek/src/MainWidgets/loader_btn.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:shobek/src/Provider/DriverProvider/sendOfferProvider.dart';

class SendOffer extends StatefulWidget {
  final int orderID;

  const SendOffer({Key key, this.orderID}) : super(key: key);

  @override
  _SendOfferState createState() => _SendOfferState();
}

class _SendOfferState extends State<SendOffer> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        appBar: defaultAppBar(
          context: context,
          title: "تقديم عرض سعر",
          hasBack: true,
          onPress: () => Navigator.pop(context),
        ),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                RegisterTextField(
                  label: 'عرض السعر',
                  icon: Icons.monetization_on,
                  type: TextInputType.number,
                  onChange: (v) {
                    Provider.of<SendtOfferProvider>(context, listen: false)
                        .price = v;
                  },
                  errorText: null,
                ),
                SizedBox(height: 20),
                DetailsTextFieldNoImg(
                  label: 'تفاصيل العرض',
                  onChange: (v) {
                    Provider.of<SendtOfferProvider>(context, listen: false)
                        .offerDetails = v;
                  },
                  hint: 'مثال.. وقت التجهيز وطريقة التغليف',
                ),
                Padding(
                  padding: EdgeInsets.all(50),
                  child: LoaderButton(
                    load: false,
                    onTap: () {
                      Provider.of<SendtOfferProvider>(context, listen: false)
                          .sendOffer(widget.orderID, context)
                          .then((v) {
                        if (v == true) {
                          Navigator.pop(context, true);
                        }
                      });
                    },
                    color: Theme.of(context).primaryColor,
                    text: 'إرسال',
                    txtColor: Colors.black,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
