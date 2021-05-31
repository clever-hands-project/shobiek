import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/notificationItem.dart';
import 'package:shobek/src/MainWidgets/app_empty.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/app_login.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/get/notificationProvider.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class NotificationsScreen extends StatefulWidget {
  final Function onBack;

  const NotificationsScreen({Key key, this.onBack}) : super(key: key);
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  TextEditingController controller = new TextEditingController();
  @override
  void initState() {
    print("object");
    Provider.of<NotoficationProvider>(context, listen: false)
        .getNotification(Provider.of<SharedPref>(context, listen: false).token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "الإشعارات",
        hasBack: widget.onBack ?? false,
        onPress: widget.onBack,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: NetworkUtil.token == null
            ? Center(
                child: AppShouldLogin(
                  text: "يرجي تسجيل الدخول اولا.",
                ),
              )
            : Provider.of<NotoficationProvider>(context, listen: true)
                        .notificationModel ==
                    null
                ? Center(child: AppLoader())
                : Provider.of<NotoficationProvider>(context, listen: true)
                                .notfications
                                .length ==
                            0 ||
                        Provider.of<NotoficationProvider>(context, listen: true)
                                .notificationModel.data ==
                            null
                    ? Center(
                        child: AppEmpty(
                        text: "لا يوجد اشعارات",
                      ))
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          NotificationCard(
                            notifications: Provider.of<NotoficationProvider>(
                                    context,
                                    listen: true)
                                .notificationModel
                                .data,
                          )
                        ],
                      ),
      ),
    );
  }
}
