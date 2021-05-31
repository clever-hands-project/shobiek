import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/MainWidgets/loader_btn.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:shobek/src/Provider/chargeOnlineProvider.dart';
import 'package:shobek/src/Provider/get/setting.dart';
import '../bankPayment.dart';

class ChargeScreen extends StatefulWidget {
  @override
  _ChargeScreenState createState() => _ChargeScreenState();
}

class _ChargeScreenState extends State<ChargeScreen> {
  String price;
  final _form = GlobalKey<FormState>();
  bool autoError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: defaultAppBar(
          context: context,
          title: "شحن المحفظة",
          hasBack: true,
          onPress: () => Navigator.pop(context),
        ),
        body: Form(
            key: _form,
            autovalidateMode:
                autoError ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  RegisterTextField(
                    onChange: (v) {
                      price = v;
                    },
                    label: 'قيمة الشحن',
                    icon: Icons.attach_money,
                    type: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  LoaderButton(
                    load: false,
                    text: 'شحن الآن',
                    color: Theme.of(context).primaryColor,
                    onTap: () {
                      setState(() {
                        autoError = true;
                      });
                      final isValid = _form.currentState.validate();
                      if (!isValid) {
                        return;
                      }
                      _form.currentState.save();
                      // paymentBloc.add(Click());
                      if (double.parse(Provider.of<SettingProvider>(context,
                                  listen: false)
                              .chargeLimit) >
                          double.parse(price)) {
                        CustomAlert().toast(
                            context: context,
                            title:
                                "الحد الادني للدفع هو ${Provider.of<SettingProvider>(context, listen: false).chargeLimit}");
                        return;
                      }
                      Provider.of<ChargeOnlineProvider>(context, listen: false)
                          .subscribe(
                              Provider.of<SharedPref>(context, listen: false)
                                  .token,
                              price,
                              context);
                    },
                    txtColor: Colors.black,
                  ),
                  SizedBox(height: 20),
                  LoaderButton(
                    load: false,
                    text: 'الشحن عن طريق تحويل للحساب البنكي',
                    color: Theme.of(context).primaryColor,
                    onTap: () {
                      setState(() {
                        autoError = true;
                      });
                      final isValid = _form.currentState.validate();
                      if (!isValid) {
                        return;
                      }
                      if (double.parse(Provider.of<SettingProvider>(context,
                                  listen: false)
                              .chargeLimit) >
                          double.parse(price)) {
                        CustomAlert().toast(
                            context: context,
                            title:
                                "الحد الادني للدفع هو ${Provider.of<SettingProvider>(context, listen: false).chargeLimit}");
                        return;
                      }
                      _form.currentState.save();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => BankingPay(
                                    price: price,
                                  )));
                    },
                    txtColor: Colors.black,
                  ),
                ],
              ),
            )));
  }
}
