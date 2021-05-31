import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChachedImg extends StatelessWidget {
  final String imag;
  final String placeError;
  final Widget child;

  const ChachedImg({Key key, this.imag, this.placeError, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imag,
       errorWidget: (context, url, error) => child,
      fadeInDuration: Duration(seconds: 2),
      placeholder: (context, url) => child,
      imageBuilder: (context, provider) {
        return child;
      },
    );
  }
}
