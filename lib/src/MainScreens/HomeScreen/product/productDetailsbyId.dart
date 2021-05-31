import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/quantityWidget.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/MainWidgets/productSlider.dart';
import 'package:shobek/src/Provider/get/productByIdProvider.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';

class ProductDetailsById extends StatefulWidget {
  final int id;
  ProductDetailsById({Key key, this.id}) : super(key: key);
  @override
  _ProductDetailsByIdState createState() => _ProductDetailsByIdState();
}

class _ProductDetailsByIdState extends State<ProductDetailsById> {
  bool isInit = true;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      await Provider.of<ProductByIdProvider>(context, listen: false)
          .getShopById(
              Provider.of<SharedPref>(context, listen: false).token, widget.id);
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "المنتج",
        hasBack: true,
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
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    // Product Slider
                    Container(
                      height: 250,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ProductSlider(
                          sliderItems: Provider.of<ProductByIdProvider>(context,
                                  listen: false)
                              .productId
                              .data
                              .photos,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // product name
                    Text(
                      Provider.of<ProductByIdProvider>(context, listen: false)
                              .productId
                              .data
                              .name ??
                          "دجاج بانيه متبل",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    //  product Category and price
                    Row(
                      children: [
                        // Category
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "قسم الوجبات",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Product Price
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // price
                              Text(
                                Provider.of<ProductByIdProvider>(context,
                                            listen: false)
                                        .productId
                                        .data
                                        .price ??
                                    "35.00",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "SR",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                            "وصف المنتج:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Text(
                                Provider.of<ProductByIdProvider>(context,
                                            listen: false)
                                        .productId
                                        .data
                                        .details ??
                                    "هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس هذا محتوي تجريبي ستم ازالته فيما بعد تبعا للظروف الجوية اليوم ف طرابلس",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Product Inventory
                    Container(
                      height: 40,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "مخزون المنتج:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "50 قطعة",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Quantity and total price
                    QuantityWidget(
                        price: double.parse(Provider.of<ProductByIdProvider>(
                                context,
                                listen: false)
                            .productId
                            .data
                            .price),
                        id: Provider.of<ProductByIdProvider>(context,
                                listen: false)
                            .productId
                            .data
                            .id),
                    SizedBox(height: 10),
                    // Add to Cart Button
                  ],
                ),
              ),
            ),
    );
  }
}
