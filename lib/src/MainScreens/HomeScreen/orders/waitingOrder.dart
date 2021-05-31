import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/countDownwatinigDriver.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/driverItem.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/orderItem.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/weekcountdawn.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/ClientOrderProvider.dart';

import 'package:shobek/src/Provider/get/offersProvider.dart';
import 'package:shobek/src/Provider/get/setting.dart';
import 'package:shobek/src/Provider/post/CancelOrderOffer.dart';
import 'package:shobek/src/Provider/post/acceptOfferProvider.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WaitingOrder extends StatefulWidget {
  @override
  _WaitingOrderState createState() => _WaitingOrderState();
}

class _WaitingOrderState extends State<WaitingOrder> {
  ClientOrdersProvider clientOrdersProvider;

  OffersProvider offersProvider;
  bool isInit = true;
  SettingProvider settingProvider;

  CustomDialog _dialog = CustomDialog();

  final String time = "6:00 ساعات";
  Future<bool> _onBackPressed() async {
    var alert = await _dialog.showOptionDialog(
        context: context,
        msg: 'هل انت متاكد سوف يتم الغاء الطلب ؟',
        okFun: () async {
          Provider.of<CancelOrderProvider>(context, listen: false)
              .clientCancelOder(clientOrdersProvider.clientOrders[0].id,
                  'العميل قام بإلغاء الطلب بنفسه', context);
        },
        okMsg: 'نعم',
        cancelMsg: 'لا',
        cancelFun: () {
          return;
        });
    return alert;
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      settingProvider = Provider.of<SettingProvider>(context, listen: false);

      await Provider.of<ClientOrdersProvider>(context, listen: false)
          .getClientOrders(0, context);
      clientOrdersProvider =
          Provider.of<ClientOrdersProvider>(context, listen: false);

      await Provider.of<OffersProvider>(context, listen: false).getOffers(
          context: context, id: clientOrdersProvider.clientOrders[0].id);
      print(clientOrdersProvider.clientOrders[0].id);
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "طلب بإنتظار السائقين",
        hasBack: true,
        onPress: () => _onBackPressed(),
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: isInit
              ? AppLoader()
              : Column(
                  children: [
                    // The Waiting Order
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10,
                      ),
                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: OrderItem(
                          image: clientOrdersProvider.clientOrders[0].shopPhoto,
                          productName:
                              clientOrdersProvider.clientOrders[0].shop,
                          productId: clientOrdersProvider.clientOrders[0].id
                              .toString(),
                          price:
                              clientOrdersProvider.clientOrders[0].orderPrice,
                          shopName: clientOrdersProvider.clientOrders[0].shop,
                          description:
                              clientOrdersProvider.clientOrders[0].orderDetails,
                        ),
                        actions: [
                          InkWell(
                            onTap: () async {
                              return await _dialog.showOptionDialog(
                                  context: context,
                                  msg: 'هل ترغب بحذف الطلب؟',
                                  okFun: () async {
                                    await Provider.of<CancelOrderProvider>(
                                            context,
                                            listen: false)
                                        .clientCancelOder(
                                            clientOrdersProvider
                                                .clientOrders[0].id,
                                            'العميل قام بإلغاء الطلب بنفسه',
                                            context);
                                  },
                                  okMsg: 'نعم',
                                  cancelMsg: 'لا',
                                  cancelFun: () {
                                    return;
                                  });
                            },
                            child: Material(
                              shape: CircleBorder(),
                              color: Colors.redAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Time
                    Container(
                      height: 40,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'سينتهي الطلب في خلال',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            WeekCountdown(
                              period: settingProvider
                                  .userDataModel.data.orderDuration,
                              createdAt: clientOrdersProvider != null
                                  ? clientOrdersProvider
                                      .clientOrders[0].orderTime
                                  : DateTime.now(),
                            ),
                            Text(
                              'في حالة عدم اختيار عرض سعر',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ]),
                    ),
                    // Drivers List
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: [
                          Consumer<OffersProvider>(builder: (context, snap, _) {
                            if (snap.offers == null ||
                                snap.offers.length <= 0) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CountdownWaitnigDriver(
                                      createdAt: DateTime.now(),
                                      period: 5,
                                      id: clientOrdersProvider
                                          .clientOrders[0].id,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05),
                                    Center(
                                      child: Text(
                                        'لايوجد سائقين متاحين الآن',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05),
                                    Container(
                                      height: mediaQuery.height * 0.05,
                                      width: mediaQuery.width * 0.35,
                                      child: ElevatedButton(
                                        // elevation: 8,
                                        // color: Theme.of(context).primaryColor,
                                        child: Text(
                                          'إلغاء الطلب',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        onPressed: () async {
                                          await _dialog.showOptionDialog(
                                              context: context,
                                              msg:
                                                  'سيتم إلغاء طلبك , هل أنت متأكد؟',
                                              okFun: () async {
                                                Provider.of<CancelOrderProvider>(
                                                        context,
                                                        listen: false)
                                                    .clientCancelOder(
                                                        clientOrdersProvider
                                                            .clientOrders[0].id,
                                                        'العميل قام بإلغاء الطلب بنفسه',
                                                        context);
                                              },
                                              okMsg: 'نعم',
                                              cancelMsg: 'لا',
                                              cancelFun: () {
                                                return;
                                              });
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              Theme.of(context).primaryColor,
                                            ),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            )),
                                        // textColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: mediaQuery.height * 0.05,
                                  ),
                                  CountdownWaitnigDriver(
                                    createdAt: DateTime.now(),
                                    period: 5,
                                    id: clientOrdersProvider.clientOrders[0].id,
                                  ),
                                  ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      physics: ClampingScrollPhysics(),
                                      itemCount: snap.offers.length,
                                      itemBuilder: (context, i) {
                                        return AnimationConfiguration
                                            .staggeredList(
                                          position: i,
                                          delay: Duration(milliseconds: 400),
                                          child: SlideAnimation(
                                            duration:
                                                Duration(milliseconds: 400),
                                            verticalOffset: 50.0,
                                            child: DriverItem(
                                              image: snap.offers[i].driverPhoto,
                                              driverName: snap.offers[i].driver,
                                              carType: snap.offers[i].carType
                                                  .toString(),
                                              price: snap.offers[i].driverPrice,
                                              isActive: true,
                                              onTap: () {
                                                _dialog.showOptionDialog(
                                                    context: context,
                                                    msg:
                                                        'هل تود قبول عرض هذا السائق',
                                                    okFun: () {
                                                      Provider.of<
                                                          AcceptOfferProvider>(
                                                        context,
                                                        listen: false,
                                                      ).acceptOffer(
                                                          snap.offers[i].id,
                                                          context);
                                                    },
                                                    okMsg: 'نعم',
                                                    cancelMsg: 'لا',
                                                    cancelFun: () {
                                                      return;
                                                    });
                                              },
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
