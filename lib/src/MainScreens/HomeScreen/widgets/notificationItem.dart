import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/Models/get/notification.dart';
import 'package:shobek/src/Provider/get/notificationProvider.dart';
import 'package:shobek/src/Provider/post/deleteNotificationProvider.dart';

class NotificationCard extends StatefulWidget {
  final List<Notifications> notifications;

  const NotificationCard({Key key, this.notifications}) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        physics: NeverScrollableScrollPhysics(),
        itemCount: Provider.of<NotoficationProvider>(context, listen: true)
            .notfications
            .length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: Duration(milliseconds: 400),
            child: SlideAnimation(
              duration: Duration(milliseconds: 400),
              verticalOffset: 50.0,
              child: FadeInAnimation(
                  child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
                  child: Row(
                    children: [
                      // Notification Image
                      Container(
                        width: 45.0,
                        height: 45.0,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/image.jpg"),
                          ),
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // Notification Details
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Notification Title
                                Text(
                                  widget.notifications[index].title  ??
                                      "عنوان الاشعار بالتفصيل",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.grey,
                                      size: 13,
                                    ),
                                    SizedBox(width: 5),
                                    // Notifications Time
                                    Text(
                                      widget.notifications[index].createdAt
                                              .toString()
                                              .substring(0, 10) ??
                                          "9:00",
                                      style: TextStyle(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    // Notification Settings
                                    InkWell(
                                      onTap: () {
                                        Provider.of<DeletNotificationProvider>(
                                                context,
                                                listen: false)
                                            .deletNot(
                                                widget.notifications[index].id,
                                                index,
                                                context)
                                            .then((v) {
                                          if (v == true) {
                                            Provider.of<NotoficationProvider>(
                                                    context,
                                                    listen: false)
                                                .getNotification(
                                                    Provider.of<SharedPref>(
                                                            context,
                                                            listen: false)
                                                        .token);
                                            // Provider.of<NotoficationProvider>(
                                            //         context,
                                            //         listen: false)
                                            //     .removeItem(index);
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 5,
                                        ),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //  Notification Description
                            Text(
                              widget.notifications[index].message ??
                                  "محتوي تجريبي يستبدل فيما بعد"
                                      "محتوي تجريبي يستبدل فيما بعد"
                                      "محتوي تجريبي يستبدل فيما بعد"
                                      "محتوي تجريبي يستبدل فيما بعد"
                                      "محتوي تجريبي يستبدل فيما بعد",
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ),
          );
        });
  }
}
