import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ProductSlider extends StatelessWidget {
  final sliderItems;

  const ProductSlider({Key key, this.sliderItems}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return sliderItems == null
        ? Center(child: Text('لا يوجد صور'))
        : Carousel(
            boxFit: BoxFit.fill,
            images: List.generate(sliderItems.length, (int index) {
              return sliderItems[index].photo != null
                  ? CachedNetworkImage(
                      imageUrl: sliderItems[index].photo,
                      fadeInDuration: Duration(seconds: 2),
                      placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                      // Container(
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //             image: AssetImage('assets/images/1.png'),
                      //             fit: BoxFit.cover),
                      //       ),
                      //     ),
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
                            image: AssetImage('assets/images/1.png'),
                            fit: BoxFit.cover),
                      ),
                    );
            }),
            autoplay: false,
            dotIncreasedColor: Theme.of(context).primaryColor,
            dotIncreaseSize: 2,
            dotSize: 5,
            dotSpacing: 20,
            autoplayDuration: Duration(seconds: 1),
            dotBgColor: Color(0x00000000),
            animationCurve: Curves.decelerate,
            animationDuration: Duration(milliseconds: 1000),
            indicatorBgPadding: 10,
            dotColor: Colors.white,
            dotVerticalPadding: 10,
          );
  }
}
