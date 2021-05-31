import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';

import 'widget/carDocument.dart';

class EditCarData extends StatefulWidget {
  @override
  _EditCarDataState createState() => _EditCarDataState();
}

class _EditCarDataState extends State<EditCarData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: defaultAppBar(
        context: context,
        title: "تعديل بيانات السيارة",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          CarDocuments(
            token: Provider.of<SharedPref>(context, listen: false).token,
          )
        ],
      ),
    );
  }
}
