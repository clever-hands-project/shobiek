import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/orderItem.dart';
import 'package:shobek/src/MainScreens/shop/ShopProduct/createProduct.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/shop/MyProductProvider.dart';
import 'package:shobek/src/Provider/shop/ProductsShopProvider.dart';
import 'ShopProduct/editProduct.dart';

class ShopProductsPage extends StatefulWidget {
  @override
  _ShopProductsPageState createState() => _ShopProductsPageState();
}

class _ShopProductsPageState extends State<ShopProductsPage> {
  @override
  void initState() {
    Provider.of<ProductsShopProvider>(context, listen: false)
        .getProducts(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: defaultAppBar(
          context: context,
          title: "منتجاتي",
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (c)=>CreateProduct()));
              },
            )
          ],
          hasBack: true,
        ),
        body: FutureBuilder(
          future: Provider.of<ShopProuctProvider>(context, listen: false)
              .getDriverOrders(
                  Provider.of<SharedPref>(context, listen: false).token,
                  "",
                  context),
          builder: (c, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return AppLoader();
              default:
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                else
                  return snapshot.data.data == null
                      ? Center(
                          child: Text("لا يوجد منتجات"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: Provider.of<ShopProuctProvider>(context,
                                  listen: false)
                              .shopProduct
                              .length,
                          itemBuilder: (c, index) => Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child:  OrderItem(
                              image: snapshot.data.data[index].photos != null
                                  ? snapshot.data.data[index].photos[0].photo
                                  : null,
                              productName: snapshot.data.data[index].name,
                              price: snapshot.data.data[index].price,
                              shopName: "المتاح: ${snapshot.data.data[index].available}",
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditProduct(
                                       shopProduct: snapshot.data.data[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                                  // child: Productcard(
                                  //   onTap: () => Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (c) => EditProduct(
                                  //                 shopProduct: Provider.of<
                                  //                             ShopProuctProvider>(
                                  //                         context,
                                  //                         listen: false)
                                  //                     .shopProduct[index],
                                  //               ))).then((v) {
                                  //     setState(() {});
                                  //   }),
                                  //   shopProduct:
                                  //       Provider.of<ShopProuctProvider>(context,
                                  //               listen: false)
                                  //           .shopProduct[index],
                                  // ),
                                ),
                                actions: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      // Provider.of<DeleteProductProvider>(
                                      //         context,
                                      //         listen: false)
                                      //     .deletNot(
                                      //         Provider.of<SharedPref>(context,
                                      //                 listen: false)
                                      //             .token,
                                      //         Provider.of<ShopProuctProvider>(
                                      //                 context,
                                      //                 listen: false)
                                      //             .shopProduct[index]
                                      //             .id,
                                      //         context)
                                      //     .then((v) {
                                      //   setState(() {});
                                      //   // _getShared();
                                      // });
                                    },
                                    child: Material(
                                      shape: CircleBorder(),
                                      color: Colors.redAccent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
            }
          }),
      ),
    );
  }
}
