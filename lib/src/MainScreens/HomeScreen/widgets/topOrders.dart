import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TopOrders extends StatefulWidget {
  @override
  _TopOrdersState createState() => _TopOrdersState();
}

class _TopOrdersState extends State<TopOrders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: AnimationLimiter(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                delay: Duration(milliseconds: 400),
                child: SlideAnimation(
                  duration: Duration(milliseconds: 400),
                  horizontalOffset: 50,
                  child: FadeInAnimation(
                      child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 180.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    AssetImage("assets/images/TENDER_CHE.jpg")),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.redAccent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'دجاج تندر',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'مطعم انذر سلايدر',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    'سندويشات',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   crossAxisAlignment: CrossAxisAlignment.end,
                              //   children: [
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 20,
                              //     ),
                              //     SizedBox(
                              //       height: 10,
                              //     ),
                              //     Text(
                              //       "4.0",
                              //       textAlign: TextAlign.center,
                              //       style:
                              //           Theme.of(context).textTheme.bodyText1,
                              //     ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     SizedBox(
                              //       height: 20,
                              //       width: 60,
                              //       child: RaisedButton(
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(18.0),
                              //         ),
                              //         padding: EdgeInsets.all(2),
                              //         color: Theme.of(context).primaryColor,
                              //         onPressed: () {},
                              //         child: Text(
                              //           "any ting",
                              //           style: TextStyle(
                              //               color: Colors.black, fontSize: 10),
                              //           textAlign: TextAlign.end,
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     SizedBox(
                              //       height: 20,
                              //       width: 60,
                              //       child: RaisedButton(
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(18.0),
                              //         ),
                              //         padding: EdgeInsets.all(2),
                              //         color: Theme.of(context).primaryColor,
                              //         onPressed: () {},
                              //         child: Text(
                              //           "any ting",
                              //           style: TextStyle(
                              //               color: Colors.black, fontSize: 10),
                              //           textAlign: TextAlign.end,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                           
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
