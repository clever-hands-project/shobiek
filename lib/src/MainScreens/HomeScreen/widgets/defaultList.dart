import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DefaultList extends StatelessWidget {
  final int length;
  final Widget widget;
  final EdgeInsetsGeometry padding;

  const DefaultList(
      {Key key, @required this.length, @required this.widget, this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        physics: ClampingScrollPhysics(),
        itemCount: length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: Duration(milliseconds: 400),
            child: SlideAnimation(
              duration: Duration(milliseconds: 400),
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
          );
        });
  }
}
