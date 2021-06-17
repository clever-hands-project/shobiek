import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget networkImage(String url,
    {double height, double width, String errorImage}) {
  return url != null
      ? CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Image(
            image: imageProvider,
            fit: BoxFit.fill,
            height: height ?? double.infinity,
            width: width ?? double.infinity,
          ),
          placeholder: (context, url) => Lottie.asset(
              'assets/images/loadingPhoto.json',
              width: double.infinity,
              height: double.infinity),
          errorWidget: (context, url, error) {
            return Image.asset(
                  "assets/icon/Clever Hands (1).png",
                  fit: BoxFit.fill,
                ) ;
          },
        )
      : Lottie.asset('assets/images/loadingPhoto.json',
          width: double.infinity, height: double.infinity);
}
