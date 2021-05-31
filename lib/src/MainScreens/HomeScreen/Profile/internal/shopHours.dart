import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/custom_button_with_icon.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Provider/shop/shopHoursProvider.dart';

class ShopHours extends StatefulWidget {
  @override
  _ShopHoursState createState() => _ShopHoursState();
}

class _ShopHoursState extends State<ShopHours> {
  String hour1 = "";
  String hour2 = "";
  @override
  void initState() {
    hour1 = 
    Provider.of<AuthController>(context, listen: false)
            .userModel
            .data
            .openTime == null ?"":
    Provider.of<AuthController>(context, listen: false)
            .userModel
            .data
            .openTime
            .contains("AM")
        ? Provider.of<AuthController>(context, listen: false)
            .userModel
            .data
            .openTime
            .replaceAll("AM", "ص")
        : Provider.of<AuthController>(context, listen: false)
            .userModel
            .data
            .openTime
            .replaceAll("PM", "م");
    hour2 = 
    Provider.of<AuthController>(context, listen: false)
            .userModel
            .data
            .closeTime == null ?"":
    Provider.of<AuthController>(context, listen: false)
            .userModel
            .data
            .closeTime
            .contains("AM")
        ? Provider.of<AuthController>(context, listen: false)
            .userModel
            .data
            .closeTime
            .replaceAll("AM", "ص")
        : Provider.of<AuthController>(context, listen: false)
            .userModel
            .data
            .closeTime
            .replaceAll("PM", "م");
    super.initState();
  }

  List<String> days = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  ];
  List<WeekDay> weekDay = [
    WeekDay(id: "0", name: "السبت", check: false),
    WeekDay(id: "1", name: "الاحد", check: false),
    WeekDay(id: "2", name: "الاتنين", check: false),
    WeekDay(id: "3", name: "الثلاثاء", check: false),
    WeekDay(id: "4", name: "الاربعاء", check: false),
    WeekDay(id: "5", name: "الخميس", check: false),
    WeekDay(id: "6", name: "الجمعة", check: false),
  ];
  String startTime;
  String endTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "مواعيد العمل ",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CustomButtonClock(
              lable: "من",
              onConfirm: (time) {
                setState(() {
                  print(TimeOfDay(hour: time.hour, minute: time.minute));
                  Provider.of<ShopHoursProvider>(context, listen: false).start =
                      TimeOfDay(hour: time.hour, minute: time.minute)
                          .toString()
                          .substring(10, 15);
                  hour1 = TimeOfDay(hour: time.hour, minute: time.minute)
                          .format(context)
                          .contains("AM")
                      ? TimeOfDay(hour: time.hour, minute: time.minute)
                          .format(context)
                          .replaceAll("AM", "ص")
                      : TimeOfDay(hour: time.hour, minute: time.minute)
                          .format(context)
                          .replaceAll("PM", "م");
                });
              },
              icon: FontAwesomeIcons.clock,
              date: hour1,
            ),
            SizedBox(
              height: 20,
            ),
            CustomButtonClock(
              lable: "الي",
              onConfirm: (time) {
                setState(() {
                  setState(() {
                    Provider.of<ShopHoursProvider>(context, listen: false).end =
                        TimeOfDay(hour: time.hour, minute: time.minute)
                            .toString()
                            .substring(10, 15);
                    hour2 = TimeOfDay(hour: time.hour, minute: time.minute)
                            .format(context)
                            .contains("AM")
                        ? TimeOfDay(hour: time.hour, minute: time.minute)
                            .format(context)
                            .replaceAll("AM", "ص")
                        : TimeOfDay(hour: time.hour, minute: time.minute)
                            .format(context)
                            .replaceAll("PM", "م");
                  });
                });
              },
              icon: FontAwesomeIcons.clock,
              date: hour2,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "ايام الاجازات",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (c, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: weekDay[index].check,
                          onChanged: (v) {
                            setState(() {
                              if (v == true) {
                                days[index] = "${index + 1}";
                              } else {
                                days[index] = null;
                              }
                              weekDay[index].check = !weekDay[index].check;
                            });
                          }),
                      Text(weekDay[index].name),
                    ],
                  );
                }),
            SizedBox(
              height: 20,
            ),
            CustomBtn(
                txtColor: Colors.black,
                text: "حفظ",
                onTap: () {
                  print("endTime $endTime");
                  Provider.of<ShopHoursProvider>(context, listen: false)
                      .shopHours(
                          context: context,
                          days: days,
                          token: Provider.of<SharedPref>(context, listen: false)
                              .token);
                },
                color: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }
}

class WeekDay {
  String id;
  String name;
  bool check;

  WeekDay({@required this.id, @required this.name, @required this.check});
}
