import 'package:shobek/src/MainWidgets/filtterCard.dart';
import 'package:shobek/src/Provider/checkProvider.dart';
import 'package:shobek/src/Provider/depatmentsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shobek/src/Provider/post/shopsProvider.dart';

class DepartmentFilter extends StatefulWidget {
  @override
  _DepartmentFilterState createState() => _DepartmentFilterState();
}

class _DepartmentFilterState extends State<DepartmentFilter> {
  int slected = 0;
  @override
  void initState() {
    Future.delayed(Duration(microseconds: 150), () {
      Provider.of<DepartMentProvider>(context, listen: false)
          .getDepartements(context);
    });
    shopsProvider = Provider.of<ShopsProvider>(context, listen: false);
    checkProvider = Provider.of<CheckProvider>(context, listen: false);
    departMentProvider =
        Provider.of<DepartMentProvider>(context, listen: false);
    all = true;
    departMentId = 0;
    super.initState();
  }

  CheckProvider checkProvider;
  DepartMentProvider departMentProvider;
  ShopsProvider shopsProvider;
  bool all;
  int departMentId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 3),
      child: Container(
        height: 50,
        child: AnimationLimiter(
          child: ListView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            children: [
              Filtter(
                onTap: () {
                  setState(() {
                    all = true;
                    departMentId = 0;
                  });
                  checkProvider.assignValueShops(
                      shops: shopsProvider.shops
                         );
                  for (int i = 0;
                      i < departMentProvider.departments.length;
                      i++) {
                    departMentProvider.departments[i].selected = false;
                  }
                },
                backgroundColor: all
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).scaffoldBackgroundColor,
                title: 'الكل',
                elevation: all ? 3 : 0,
                titleColor:
                    all ? Theme.of(context).accentColor : Colors.black87,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount:
                      Provider.of<DepartMentProvider>(context, listen: true)
                          .departments
                          .length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: Duration(milliseconds: 400),
                      child: SlideAnimation(
                        duration: Duration(milliseconds: 400),
                        horizontalOffset: 50,
                        child: FadeInAnimation(
                          child: Filtter(
                            title: departMentProvider.departments[index].name,
                            onTap: () {
                              setState(() {
                                all = false;
                                departMentProvider.departments[index].selected =
                                    true;
                                for (int i = 0;
                                    i < departMentProvider.departments.length;
                                    i++) {
                                  setState(() {
                                    if (i == index) {
                                      departMentProvider
                                          .departments[i].selected = true;
                                      departMentId =
                                          departMentProvider.departments[i].id;
                                    } else {
                                      Provider.of<DepartMentProvider>(context,
                                              listen: false)
                                          .departments[i]
                                          .selected = false;
                                    }
                                    checkProvider.assignValueShops(
                                        shops: shopsProvider.shops
                                            .where((e) =>
                                                e.departmentId ==
                                                    departMentId
                                              )
                                            .toList());
                                  });
                                }
                              });
                            },
                            backgroundColor: Provider.of<DepartMentProvider>(
                                        context,
                                        listen: true)
                                    .departments[index]
                                    .selected
                                ? Theme.of(context).primaryColor
                                : null,
                            elevation: Provider.of<DepartMentProvider>(context,
                                        listen: true)
                                    .departments[index]
                                    .selected
                                ? 3
                                : null,
                            titleColor: Provider.of<DepartMentProvider>(context,
                                        listen: true)
                                    .departments[index]
                                    .selected
                                ? Theme.of(context).accentColor
                                : Colors.black54,
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
