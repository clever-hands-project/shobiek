import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/cartButtons.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/orderItem.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Models/get/getCartModel.dart';
import 'package:shobek/src/Provider/get/getCartProvider.dart';

import 'package:shobek/src/MainScreens/HomeScreen/widgets/shopDetailsById.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shobek/src/MainWidgets/app_login.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'orderFinish.dart';

class CartScreen extends StatefulWidget {
  final Function onBack;

  CartScreen({Key key, this.onBack}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isEmpty = false;

  TextEditingController controller = new TextEditingController();

  CustomDialog _dialog = CustomDialog();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: defaultAppBar(
        context: context,
        title: "السلة",
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
            : Stack(
                children: [
                  FutureBuilder<GetCartModel>(
                      future:
                          Provider.of<GetCartProvider>(context, listen: false)
                              .getCart(context),
                      builder: (context, snapShot) {
                        if (snapShot.connectionState == ConnectionState.none) {
                          return Text('يرجي اعادة الاتصال بالانترنت');
                        } else if (snapShot.connectionState ==
                            ConnectionState.waiting) {
                          return AppLoader();
                        } else if (!snapShot.hasData) {
                          return Center(
                            child: Text(
                              'السلة فارغه',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          );
                        } else {
                          return Consumer<GetCartProvider>(
                              builder: (context, snap, _) {
                            if (snap.carts == null || snap.carts.length <= 0) {
                              return Center(
                                child: Text(
                                  'السلة فارغه',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                            return ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 140),
                              physics: ScrollPhysics(),
                              children: [
                                ListView.builder(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    physics: ClampingScrollPhysics(),
                                    itemCount: snap.carts.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: i,
                                        delay: Duration(milliseconds: 400),
                                        child: SlideAnimation(
                                          duration: Duration(milliseconds: 400),
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: Slidable(
                                              actionPane:
                                                  SlidableDrawerActionPane(),
                                              actionExtentRatio: 0.25,
                                              child: OrderItem(
                                                image: snap
                                                    .carts[i].photos[0].photo,
                                                productName:
                                                    snap.carts[i].productName,
                                                productId: snap
                                                    .carts[i].quantity
                                                    .toString(),
                                                price: snap.carts[i].price,
                                                shopName:
                                                    snap.carts[i].shopName,
                                                key: UniqueKey(),
                                                order: false,
                                                description: snap
                                                    .carts[i].createdAt
                                                    .toString()
                                                    .substring(0, 10),
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ShopDetailsById(
                                                                id: Provider.of<
                                                                    GetCartProvider>(
                                                                  context,
                                                                  listen: false,
                                                                ).carts[0].shopId,
                                                              )));
                                                },
                                              ),
                                              actions: [
                                                InkWell(
                                                  onTap: () async {
                                                    return await _dialog
                                                        .showOptionDialog(
                                                            context: context,
                                                            msg:
                                                                'هل ترغب بحذف الطلب؟',
                                                            okFun: () {
                                                              Provider.of<
                                                                  GetCartProvider>(
                                                                context,
                                                                listen: false,
                                                              ).deleteCart(
                                                                context,
                                                                snap.carts[i]
                                                                    .id,
                                                              );
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Icon(Icons.delete,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                              ],
                            );
                          });
                        }
                      }),
                  // Cart Action Buttons
                  CartButtons(
                    onConfirm: () async {
                      if (Provider.of<GetCartProvider>(
                            context,
                            listen: false,
                          ).carts.length >
                          0) {
                        await _dialog.showOptionDialog(
                            context: context,
                            msg: 'هل ترغب بتأكيد الطلب؟',
                            okFun: () async {
                              // await Provider.of<PostCurrentOrderProvider>(
                              //   context,
                              //   listen: false,
                              // ).postCart(context);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FinishOrder()));
                            },
                            okMsg: 'نعم',
                            cancelMsg: 'لا',
                            cancelFun: () {
                              return;
                            });
                      }
                    },
                    emptyCart: () async {
                      if (Provider.of<GetCartProvider>(
                            context,
                            listen: false,
                          ).carts.length >
                          0) {
                        await _dialog.showOptionDialog(
                            context: context,
                            msg: 'سيتم حذف جميع المنتجات من السلة متأكد؟',
                            okFun: () async {
                              await Provider.of<GetCartProvider>(
                                context,
                                listen: false,
                              )
                                  .emptyCart(context)
                                  .whenComplete(() => setState(() {}));
                            },
                            okMsg: 'نعم',
                            cancelMsg: 'لا',
                            cancelFun: () {
                              return;
                            });
                      }
                    },
                    goHome: () {
                      if (Provider.of<GetCartProvider>(
                            context,
                            listen: false,
                          ).carts.isEmpty ||
                          Provider.of<GetCartProvider>(
                                context,
                                listen: false,
                              ).carts ==
                              null) {
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShopDetailsById(
                                  id: Provider.of<GetCartProvider>(
                                    context,
                                    listen: false,
                                  ).carts[0].shopId,
                                )));
                      }
                    },
                  )
                ],
              ),
      ),
    );
  }
}
