import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/map_helper.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/shopItem.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/streetCard.dart';
import 'package:shobek/src/MainWidgets/customSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/customSliderImage.dart';
import 'package:shobek/src/Provider/checkProvider.dart';
import 'package:shobek/src/Provider/get/sliderProvider.dart';
import 'package:shobek/src/Provider/post/shopsProvider.dart';
import '../mainPage.dart';
import 'widgets/departmentFilter.dart';
import 'widgets/shopDetails.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/Models/get/SliderModle.dart';
import 'package:shobek/src/MainWidgets/customScrollPhysics.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  Widget shopDetails;
  String item;
  bool isInit = true;

  @override
  void didChangeDependencies() async {
    if (isInit) {
      await Provider.of<ShopsProvider>(context, listen: false)
          .getShops(0, null, context);
      Provider.of<CheckProvider>(context, listen: false).assignValueShops(
          shops: Provider.of<ShopsProvider>(context, listen: false).shops);
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          Container(
            height: 250,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                FutureBuilder<SliderModel>(
                    future: Provider.of<SliderProvider>(context, listen: false)
                        .getSlider(),
                    builder: (context, snapShot) {
                      if (snapShot.data == null ||
                          snapShot.hasError ||
                          snapShot.connectionState == ConnectionState.waiting) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/1.png'),
                                fit: BoxFit.cover),
                          ),
                        );
                      } else {
                        return Stack(
                          children: [
                            CustomSliderImage(
                              sliderItems: snapShot.data.data,
                            ),
                            Visibility(
                                visible: Provider.of<MapHelper>(context,
                                            listen: true)
                                        .currentLocation ==
                                    null,
                                child: InkWell(
                                    onTap: () async {
                                      await Provider.of<MapHelper>(context,
                                              listen: false)
                                          .getLocation();
                               

                                      if (Provider.of<MapHelper>(context,
                                                  listen: false)
                                              .currentLocation !=
                                          null) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainPage()),
                                            (Route<dynamic> route) => false);
                                      }
                                    },
                                    child: StreetCard())),
                          ],
                        );
                      }
                    }),
                CustomSearchBar(),
              ],
            ),
          ),
          DepartmentFilter(),
          // Shop List or ShopDetail
          Directionality(
            textDirection: TextDirection.rtl,
            child: isInit
                ? AppLoader()
                : Consumer<CheckProvider>(builder: (context, ch, _) {
                    if (ch == null || ch.shopsFilter == null || ch.isLoading) {
                      return AppLoader();
                    } else if ((ch.shopsFilter.length == 0 &&
                            ch.errorMessage != null) ||
                        (ch.errorMessage != null)) {
                      return Center(child: Text('لا يوجد منتجات'));
                    } else if (ch.controller != null &&
                        ch.errorMessage == null &&
                        ch.searchResults != null &&
                        ch.searchResults.length > 0) {
                      return ListView.builder(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          physics: ClampingScrollPhysics(),
                          itemCount: ch.searchResults.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              delay: Duration(milliseconds: 400),
                              child: SlideAnimation(
                                duration: Duration(milliseconds: 400),
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: ShopItem(
                                    open: ch.searchResults[index].open,
                                    image: ch.searchResults[index].photo,
                                    shopName: ch.searchResults[index].name,
                                    distance: ch.searchResults[index].distance
                                            .toString() ??
                                        "0",
                                    productQuantity: ch
                                        .searchResults[index].productsNumber
                                        .toString(),
                                    view: ch.searchResults[index].viewCount
                                        .toString(),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) => ShopDetails(
                                                    shops:
                                                        ch.shopsFilter[index],
                                                  )));
                                    },
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return ch.shopsFilter.length == 0
                          ? Center(child: Text('لا يوجد محلات'))
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              physics: CustomScrollPhysics(),
                              itemCount: ch.shopsFilter.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  delay: Duration(milliseconds: 400),
                                  child: SlideAnimation(
                                    duration: Duration(milliseconds: 400),
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: ShopItem(
                                        open: ch.shopsFilter[index].open,
                                        image: ch.shopsFilter[index].photo,
                                        shopName: ch.shopsFilter[index].name,
                                        distance: ch.shopsFilter[index].distance
                                                .toString() ??
                                            "0",
                                        productQuantity: ch
                                            .shopsFilter[index].productsNumber
                                            .toString(),
                                        view: ch.shopsFilter[index].viewCount
                                            .toString(),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) => ShopDetails(
                                                        shops: ch
                                                            .shopsFilter[index],
                                                      )));
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              });
                    }
                  }),
          ),
        ],
      ),
    );
  }
}
