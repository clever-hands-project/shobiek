import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import 'package:shobek/src/MainScreens/HomeScreen/product/productDetailsbyId.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/iconButton.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/orderItem.dart';
import 'package:shobek/src/MainScreens/Registeration/sign_in_screen.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/custom_bottom_sheet.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/MainWidgets/productSlider.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';
import 'package:shobek/src/Provider/addAdToFavProvider.dart';
import 'package:shobek/src/Provider/checkProvider.dart';
import 'package:shobek/src/Provider/get/getMyFavShopsProvider.dart';
import 'package:shobek/src/Provider/get/shopByIdProvider.dart';
import 'package:shobek/src/Provider/post/productFiltterProvider.dart';
import 'package:shobek/src/Provider/post/reportShopProvider.dart';
import 'package:shobek/src/Provider/post/shopViewProvider.dart';
import 'categoriesFilter.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:flutter/scheduler.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ShopDetailsById extends StatefulWidget {
  final int id;

  const ShopDetailsById({Key key, this.id}) : super(key: key);

  @override
  _ShopDetailsByIdState createState() => _ShopDetailsByIdState();
}

class _ShopDetailsByIdState extends State<ShopDetailsById> {
  bool isInit = true;
  ShopByIdProvider shopById;
  String shareLink;
  bool isFavourite = true;
  CustomDialog _dialog = CustomDialog();
  _saveForm() async {
    if (NetworkUtil.token == null) {
      return await _dialog.showOptionDialog(
          context: context,
          msg: 'للاعجاب يرجي التسجيل اولا',
          okFun: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => SignInScreen()));
          },
          okMsg: 'نعم',
          cancelMsg: 'لا',
          cancelFun: () {
            return;
          });
    } else {
      if (!isFavourite) {
        await Provider.of<AddAdToFavProvider>(context, listen: false)
            .addAdToFav(NetworkUtil.token, widget.id, context);
        setState(() {
          isFavourite = true;
        });
      } else {
        await Provider.of<GetMyFavShopProvider>(context, listen: false)
            .deleteFavShop(context, widget.id, NetworkUtil.token);
        setState(() {
          isFavourite = false;
        });
      }
    }
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      await Provider.of<ProductFiltterProvider>(context, listen: false)
          .getProductFiltter(widget.id, 0);
      await Provider.of<ShopByIdProvider>(context, listen: false)
          .getShopById(widget.id);
      shopById = Provider.of<ShopByIdProvider>(context, listen: false);
      if (NetworkUtil.token != null) {
        await Provider.of<ShopViewProvider>(context, listen: false)
            .shopView(context, widget.id);
      }

      if (shopById.shopByIdModle.data.favorite == 0) {
        setState(() {
          isFavourite = false;
        });
      } else {
        setState(() {
          isFavourite = true;
        });
      }
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Provider.of<CheckProvider>(context, listen: false).assignValueProduct(
            products:
                Provider.of<ProductFiltterProvider>(context, listen: false)
                    .products);
      });
      _createDynamicLink();
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  Future<void> _createDynamicLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://shobeek.page.link',
      link: Uri.parse('https://shobeek.page.link/0/${widget.id}'),
      androidParameters: AndroidParameters(
        packageName: 'com.tqnee.shobek',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.tqnee.shobek',
        minimumVersion: "4",
      ),
    );

    Uri url;
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    url = shortLink.shortUrl;
    setState(() {
      shareLink = url.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "تفاصيل المطعم",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: isInit
          ? AppLoader()
          : Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: ListView(
                  children: [
                    // Product Slider
                    Container(
                      height: 250,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ProductSlider(
                          sliderItems: shopById.shopByIdModle.data.photos,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Directionality(
                            textDirection: TextDirection.ltr,
                            child: CategoriesFiltter()),
                        // shop name and action buttons
                        Row(
                          children: [
                            // Shop Name
                            Text(
                              shopById.shopByIdModle.data.name ??
                                  "اسم المتجر بالتفصيل",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            // share Button
                            CustomIconButton(
                              icon: Icons.reply,
                              onTap: () async {
                                String _msg;
                                StringBuffer _sb = new StringBuffer();
                                setState(() {
                                  _sb.write(
                                      "اسم المتجر : ${shopById.shopByIdModle.data.name} \n");

                                  _sb.write(shareLink);

                                  _msg = _sb.toString();
                                });
                                if (shopById.shopByIdModle.data.photos !=
                                    null) {
                                  if (shopById
                                          .shopByIdModle.data.photos.length !=
                                      0) {
                                    var request = await HttpClient().getUrl(
                                        Uri.parse(shopById.shopByIdModle.data
                                            .photos[0].photo));
                                    var response = await request.close();
                                    Uint8List bytes =
                                        await consolidateHttpClientResponseBytes(
                                            response);
                                    await Share.file('ESYS AMLOG', 'amlog.jpg',
                                        bytes, 'image/jpg',
                                        text: _msg);
                                  } else {
                                    Share.text("title", _msg, 'text/plain');
                                  }
                                } else {
                                  Share.text("title", _msg, 'text/plain');
                                }
                              },
                            ),
                            SizedBox(width: 3),
                            //  Fav Button
                            CustomIconButton(
                              icon: isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              iconColor: isFavourite
                                  ? Colors.red
                                  : Color.fromRGBO(72, 83, 103, 1),
                              onTap: _saveForm,
                            ),
                            SizedBox(width: 3),
                            // Info Button
                            CustomIconButton(
                                icon: Icons.priority_high_rounded,
                                onTap: () async {
                                  if (NetworkUtil.token == null) {
                                    return await _dialog.showOptionDialog(
                                        context: context,
                                        msg: 'للابلاغ يرجي التسجيل اولا',
                                        okFun: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      SignInScreen()));
                                        },
                                        okMsg: 'نعم',
                                        cancelMsg: 'لا',
                                        cancelFun: () {
                                          return;
                                        });
                                  } else {
                                    CustomBottomSheet().show(
                                        context: context,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RegisterTextField(
                                                onChange: (v) {
                                                  Provider.of<ReportShopProvider>(
                                                          context,
                                                          listen: false)
                                                      .details = v;
                                                },
                                                label: 'سبب الابلاغ',
                                                icon: Icons.label,
                                                type: TextInputType.text,
                                              ),
                                              SizedBox(height: 20),
                                              CustomBtn(
                                                text: 'تاكيد الابلاغ',
                                                color: Colors.red,
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  await Provider.of<
                                                              ReportShopProvider>(
                                                          context,
                                                          listen: false)
                                                      .reportShop(
                                                          widget.id,
                                                          NetworkUtil.token,
                                                          context);
                                                },
                                                txtColor: Colors.white,
                                              )
                                            ],
                                          ),
                                        ));
                                  }
                                }),
                          ],
                        ),
                        // Shop Description
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 15,
                          ),
                          padding: const EdgeInsets.all(15),
                          constraints: BoxConstraints(
                            maxHeight: 200,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "وصف المتجر:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Flexible(
                                child: SingleChildScrollView(
                                  child: Text(
                                    shopById.shopByIdModle.data.details ??
                                        "هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          "المنتجات",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        // Product List
                        Consumer<CheckProvider>(builder: (context, ch, _) {
                          if (ch == null || ch.productsFilter == null) {
                            return AppLoader();
                          } else if (ch.productsFilter.length == 0) {
                            return Center(child: Text('لا يوجد منتجات'));
                          } else {
                            return ListView.builder(
                                primary: false,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                physics: ClampingScrollPhysics(),
                                itemCount: ch.productsFilter == null
                                    ? 0
                                    : ch.productsFilter.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    delay: Duration(milliseconds: 400),
                                    child: SlideAnimation(
                                      duration: Duration(milliseconds: 400),
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: OrderItem(
                                          image: ch.productsFilter[index]
                                              .photos[0].photo,
                                          productName:
                                              ch.productsFilter[index].name,
                                          price: ch.productsFilter[index].price,
                                          shopName:
                                              "المتاح: ${ch.productsFilter[index].available}",
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsById(
                                                  id: ch
                                                      .productsFilter[index].id,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
