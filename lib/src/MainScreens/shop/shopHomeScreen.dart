import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/internal/shopHours.dart';
import 'package:shobek/src/MainScreens/driver/driverCommitions.dart';
import 'package:shobek/src/MainScreens/shop/shopOrders.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/networkImage.dart';
import 'package:shobek/src/MainWidgets/profileAppBar.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Models/auth/AuthModle.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'productsShopPage.dart';

class ShopHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthModel user =
        Provider.of<AuthController>(context, listen: true).userModel;

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileAppBar(
              title: "${user.data.name}",
              name: "${user.data.city}",
              location: "${user.data.address}",
              hasBack: false,
              image: Container(
                height: 80,
                width: 80,
                // backgroundImage: AssetImage('assets/images/avatar.jpeg'),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: networkImage("${user.data.photo}",
                      errorImage: "assets/images/avatar.jpeg"),
                ),
              ),
            ),
            SizedBox(height: 40),
            // Days of Work
            Provider.of<AuthController>(context, listen: false)
                        .userModel
                        .data
                        .closeTime ==
                    null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "لم يتم تحديد موعيد للعمل",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      SizedBox(width: 2),
                      InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (c) => ShopHours())),
                        child: Text(
                          "مواعيد العمل؟",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "مواعيد العمل",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      // Text(
                      //   "جميع أيام الأسبوع عدا",
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // SizedBox(width: 2),
                      // Text(
                      //   "يوم الجمعة",
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.red,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // )
                    ],
                  ),
            SizedBox(height: 10),
            // Time of work
            Provider.of<AuthController>(context, listen: false)
                        .userModel
                        .data
                        .closeTime ==
                    null
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "من الساعة",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                        "${user.data.openTime}",
                        // "${time.DateFormat.Hm().format(DateTime.parse())}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "إلي الساعة",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                        "${user.data.closeTime}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 40),
            CustomBtn(
              heigh: 60,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              txtColor: Theme.of(context).accentColor,
              text: "منتجاتي",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShopProductsPage(),
                  ),
                );
              },
            ),
            CustomBtn(
              heigh: 60,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              txtColor: Theme.of(context).accentColor,
              text: "طلباتي",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShopOrderScreen(),
                  ),
                );
              },
            ),
            CustomBtn(
              heigh: 60,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
              txtColor: Colors.white,
              text: "عمولاتي",
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => Commitions(
                              url: "shop-commission",
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
