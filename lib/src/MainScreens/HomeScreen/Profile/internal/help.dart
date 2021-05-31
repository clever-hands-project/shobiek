import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/MainWidgets/details_text_field_no_img%20copy.dart';
import 'package:shobek/src/MainWidgets/loader_btn.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:shobek/src/Provider/helpCenterProvider.dart';

class HelpCenter extends StatefulWidget {
  final int orderId;

  const HelpCenter({Key key, this.orderId}) : super(key: key);
  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: defaultAppBar(
        context: context,
        title: 'شكوي',
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RegisterTextField(
            label: 'عنوان الرسالة',
            type: TextInputType.text,
            onChange: (v) {
               Provider.of<ComplaintProvider>(context,listen: false).title = v;
            },
            icon: Icons.label,
          ),
          SizedBox(height: 20),
          DetailsTextFieldNoImg(
            onChange: (v) {
               Provider.of<ComplaintProvider>(context,listen: false).content = v;
            },
            label: 'مُحتوى الرسالة',
            hint: "",
          ),
          Padding(
            padding: EdgeInsets.all(50),
            child: LoaderButton(
              onTap: () {
                Provider.of<ComplaintProvider>(context,listen: false).complaint(widget.orderId, context);
              },
              load: false,
              text: 'إرسال',
              color: Theme.of(context).primaryColor,
              txtColor: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
