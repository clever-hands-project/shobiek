import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Bloc/app_event.dart';
import 'package:shobek/src/Bloc/chat_bloc.dart';
import 'package:shobek/src/Helpers/route.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainScreens/driver/driverMainPage.dart';
import 'package:shobek/src/MainScreens/mainPage.dart';
import 'package:shobek/src/Models/DriverModel/DriverOrderModle.dart';
import 'package:shobek/src/Models/chat/msg_model.dart';
import 'package:shobek/src/Provider/ClientOrderProvider.dart';
import 'package:shobek/src/Provider/DriverProvider/ClientCancleOrderProvider.dart';
import 'package:shobek/src/Provider/DriverProvider/DriverOrderProvider.dart';
import 'package:shobek/src/Provider/DriverProvider/driverCancelOrderProvider.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'Widgets/chat_field.dart';
import 'Widgets/msg_card.dart';
import 'Widgets/popup_menu.dart';

class ChatRoom extends StatefulWidget {
  final int chateId;
  final String phone;
  final String userName;
  final DriverOrder driverOrder;
  final String orderPrice;
  final String price;

  const ChatRoom(
      {Key key,
      this.chateId,
      this.userName,
      this.phone = "010",
      this.driverOrder,
      this.orderPrice,
      this.price})
      : super(key: key);
  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatRoom> with TickerProviderStateMixin {
  List<MsgModel> _messages = [];

  ScrollController _scrollController;
  double _scrollPosition;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
    if (_scrollPosition > 200.0) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Timer timer;
  DriverOrder driverOrder2;
  @override
  void initState() {
    driverOrder2 = widget.driverOrder;
    chatBloc.updateContext(context);
    chatBloc.updateChatID(widget.chateId);
    chatBloc.add(Init());
    super.initState();

    chatBloc.messages.listen((event) {
      setState(() {
        _messages.insert(0, event);
      });
    });
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (Provider.of<AuthController>(context, listen: false)
              .userModel
              .data
              .type ==
          2) {
        setState(() {
          driverOrder2 =
              Provider.of<DriverOrdersProvider>(context, listen: false)
                  .driverOrders[0];
        });
        Provider.of<DriverOrdersProvider>(context, listen: false)
            .getDriverOrders(
                Provider.of<SharedPref>(context, listen: false).token,
                "1",
                context)
            .then((value) {
          if (Provider.of<DriverOrdersProvider>(context, listen: false)
                  .driverOrders
                  .length ==
              0) {
            pushAndRemoveUntil(context, DriverMainPage());
            timer.cancel();
          }
        });
      } else {
        Provider.of<ClientOrdersProvider>(context, listen: false)
            .getClientOrders(1, context)
            .then((value) {
          if (Provider.of<ClientOrdersProvider>(context, listen: false)
                  .clientOrders
                  .length ==
              0) {
            pushAndRemoveUntil(context, MainPage());
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    chatBloc.clear();
    timer.cancel();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "في حالة الخروج سيتم الغاء الطلب",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text("لا")),
                TextButton(
                    onPressed: () {
                      if (Provider.of<AuthController>(context, listen: false)
                              .userModel
                              .data
                              .type ==
                          2) {
                        Provider.of<DriverCancelOrderProvider>(context,
                                listen: false)
                            .cancelOrder(widget.chateId, context)
                            .then((v) {
                          if (v == true) {
                            timer.cancel();
                          }
                        });
                      } else {
                        Provider.of<ClientCancleOrderProvider>(context,
                                listen: false)
                            .cancelOrder(widget.chateId, context)
                            .then((v) {
                          if (v == true) {
                            timer.cancel();
                          }
                        });
                      }
                    },
                    child: Text("نعم"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'طلب رقم',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                Text(
                  "${widget.chateId}" ?? "0",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'قيمة التوصيل',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                driverOrder2 == null
                    ? Text(
                        widget.price ?? "0",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      )
                    : Text(
                        driverOrder2.price ?? "0",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'قيمة الطلب',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                driverOrder2 == null
                    ? Text(
                        widget.orderPrice ?? "0",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      )
                    : Text(
                        driverOrder2.orderPrice.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
              ],
            ),
          ],
        ),
        leading: InkWell(
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
            onTap: () {
              _onBackPressed();
            }),
        actions: <Widget>[
          PopupWidget(
              phone: widget.phone,
              orderID: widget.chateId,
              driverOrder: driverOrder2
              // driverID: widget.secondUserID,
              // billPhoto: _messages.length == 0 ? null : _messages[0].billPhoto,
              )
        ],
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: _messages.length,
                      padding: new EdgeInsets.all(6.0),
                      itemBuilder: (_, int index) {
                        return MsgCard(
                          model: _messages[index],
                        );
                      }),
                ),
                ChatField()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
