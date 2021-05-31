import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/photoGallaryString.dart';

class ShopProductDetails extends StatelessWidget {
  final  products;

  const ShopProductDetails({Key key, this.products}) : super(key: key);
  Widget _imageSlider(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.3,
      // width: mediaQuery.width,
      child: Carousel(
        boxFit: BoxFit.fill,
        images: List.generate(products.photos.length, (int index) {
          List<String> photos = [];
          for (int i = 0; i < products.photos.length; i++) {
            photos.add(products.photos[i].photo);
          }
          return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PhotoGallaryString(
                          images: photos,
                        ))),
            child: products.photos[index].photo != null
                ? CachedNetworkImage(
                    imageUrl: products.photos[index].photo,
                    fadeInDuration: Duration(seconds: 2),
                    placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/icon-001.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                    imageBuilder: (context, provider) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: provider, fit: BoxFit.fill),
                        ),
                      );
                    })
                : Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/icon-001.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
          );
        }),
        autoplay: false,
        dotSize: 4,
        dotSpacing: products.productName.length > 13
            ? 300 / products.productName.length
            : 20,
        autoplayDuration: Duration(seconds: 1),
        dotBgColor: Colors.black26,
        animationCurve: Curves.decelerate,
        animationDuration: Duration(milliseconds: 1000),
        indicatorBgPadding: 10,
        dotColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل الطلب"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          // width: mediaQuery.width * 0.9,
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              _imageSlider(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: mediaQuery.height * 0.03,
                    ),
                    Row(
                      children: [
                        Row(children: [
                          Text(
                            'SR',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: mediaQuery.width * 0.01,
                          ),
                          Text(
                            '${products.price}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                        Expanded(child: Text('')),
                        Row(children: [
                          Text(
                            '${products.shop}',
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            ' : قسم ',
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ],
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.03,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Text(
                        '${products.quantity}  علبة ',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.width * 0.01,
                      ),
                      Text(
                        ' :  مخزون المنتج',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: mediaQuery.height * 0.03,
                    ),
                    Text(
                      ': وصف المنتج ',
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        products.name,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.03,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
