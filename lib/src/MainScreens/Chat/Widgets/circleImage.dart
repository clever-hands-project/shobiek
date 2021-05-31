import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleUserImage extends StatelessWidget {
  final String userPhoto;
  final String errorPhoto;

  const CircleUserImage({Key key, this.userPhoto, this.errorPhoto})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return userPhoto == ""
        ? Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(100)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(errorPhoto,
                    // 'assets/images/person.png',
                    fit: BoxFit.contain)),
          )
        : Container(
            height: 40,
            width: 40,
            child: CachedNetworkImage(
              imageUrl: userPhoto,
              errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('assets/images/person.png',
                      fit: BoxFit.contain)),
              fadeInDuration: Duration(seconds: 2),
              placeholder: (context, url) => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('assets/images/person.png',
                      fit: BoxFit.contain)),
              imageBuilder: (context, provider) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: provider,
                      fit: BoxFit.cover,
                    ));
              },
            ),
          );
  }
}
