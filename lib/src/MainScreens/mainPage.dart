import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainScreens/HomeScreen/orders/waitingOrder.dart';
import 'package:shobek/src/MainWidgets/app_bottom_bar.dart';
import 'package:shobek/src/Models/chat/ols_messages_model.dart';
import 'package:shobek/src/Provider/ClientOrderProvider.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'HomeScreen/Profile/profile.dart';
import 'HomeScreen/cart/cart.dart';
import 'HomeScreen/notifications/notifications.dart';
import 'HomeScreen/orders/orders.dart';
import 'HomeScreen/product/productDetailsbyId.dart';
import 'HomeScreen/userHomeScreen.dart';
import 'HomeScreen/widgets/shopDetailsById.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';

class MainPage extends StatefulWidget {
  final int index;
  MainPage({this.index});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  var _bottomNavIndex = 2;
  var _bottomNavIndex2 = 1;
  bool isInit = true;
  bool orderWaiting = false;
  OldMessagesModel oldMessagesModel;
  ClientOrdersProvider clientOrdersProvider;
  getShared() async {
    if (NetworkUtil.token != null) {
   
      await Provider.of<ClientOrdersProvider>(context, listen: false)
          .getClientOrders(0, context);
      clientOrdersProvider =
          Provider.of<ClientOrdersProvider>(context, listen: false);
      if (clientOrdersProvider.clientOrders.length > 0) {
        setState(() {
          orderWaiting = true;
        });
      }
    }

    selectedpage();
  }

  List<Widget> widgets = [
    NotificationsScreen(),
    CartScreen(),
    UserHomeScreen(),
    OrderScreen(),
    ProfileScreen(),
    UserHomeScreen()
  ];
  List<Widget> widgets2 = [
    NotificationsScreen(),
    WaitingOrder(),
    UserHomeScreen(),
    OrderScreen(),
    ProfileScreen(),
    UserHomeScreen()
  ];

  void selectedpage() {
    if (widget.index != null) {
      if (!orderWaiting) {
        setState(() {
          _bottomNavIndex = widget.index;
        });
      } else {
        setState(() {
          _bottomNavIndex2 = widget.index;
        });
      }
    }
  }

  @override
  void initState() {
    _initDynamicLinks();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      await getShared();
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  void _initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print(' ---------- ' + deepLink.path);
      String _state = deepLink.path.substring(1);
      print('state >>>>> ' + _state);

      String _value = _state.substring(2);
      print('value >>>>> ' + _value);
      if (_state.contains("0/")) {
        print('state >>>>>>>>>>>>>> "Shop"' + _state);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ShopDetailsById(
                  key: UniqueKey(),
                  id: int.parse(_value),
                )));
      } else {
        print('state >>>>>>>>>>>>>>>>> "product" ' + _state);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsById(
                  key: UniqueKey(),
                  id: int.parse(_value),
                )));
      }
    } else {}

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      if (deepLink != null) {
        print(' ---------- ' + deepLink.path);
        String _state = deepLink.path.substring(1);
        print('state >>>>> ' + _state);

        String _value = _state.substring(2);
        print('value >>>>> ' + _value);
        if (_state.contains("0/")) {
          print('state >>>>>>>>>>>>>> "Shop"' + _state);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ShopDetailsById(
                    key: UniqueKey(),
                    id: int.parse(_value),
                  )));
        } else {
          print('state >>>>>>>>>>>>>>>>> "product" ' + _state);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailsById(
                    key: UniqueKey(),
                    id: int.parse(_value),
                  )));
        }
      } else {}
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: isInit
          ? AppLoader()
          : !orderWaiting
              ? widgets[_bottomNavIndex]
              : widgets2[_bottomNavIndex2],
      bottomNavigationBar: AppBottomBar(
        userType: "user",
        onTap: (v) {
          setState(() {
            if (!orderWaiting) {
              _bottomNavIndex = v;
            } else {
              _bottomNavIndex2 = v;
            }
          });
        },
        inx: !orderWaiting ? _bottomNavIndex : _bottomNavIndex2,
      ),
    );
  }
}
