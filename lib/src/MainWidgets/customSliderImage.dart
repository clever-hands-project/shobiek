import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/shopDetailsById.dart';
import 'package:shobek/src/Models/get/SliderModle.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomSliderImage extends StatelessWidget {
  final List<SliderItems> sliderItems;
  _launchURL(String link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  const CustomSliderImage({
    Key key,
    this.sliderItems,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Carousel(
      boxFit: BoxFit.fill,
      images: List.generate(sliderItems.length, (int index) {
        return InkWell(
          onTap: () {
            if (sliderItems[index].providerId != null) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShopDetailsById(
                        id: sliderItems[index].providerId,
                      )));
            } else {
              _launchURL(sliderItems[index].url);
            }
          },
          child: CachedNetworkImage(
              imageUrl: sliderItems[index].photo,
              fadeInDuration: Duration(seconds: 2),
              placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/1.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
              imageBuilder: (context, provider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: provider, fit: BoxFit.fill),
                  ),
                );
              }),
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
