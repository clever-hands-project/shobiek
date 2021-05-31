import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:photo_view/photo_view.dart';

class PhotoGallaryString extends StatefulWidget {
  final List<String> images;
  final String content;

  const PhotoGallaryString({Key key, this.images, this.content})
      : super(key: key);
  @override
  _PhotoGallaryStringState createState() => _PhotoGallaryStringState();
}

class _PhotoGallaryStringState extends State<PhotoGallaryString> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("   "),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.images.length == 0 ? "0" : _index.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 22)),
                      Text(' / ',
                          style: TextStyle(color: Colors.white, fontSize: 22)),
                      Text(widget.images.length.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 22)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              widget.images.length == 0
                  ? Container(
                      height: 600,
                      child: Center(
                        child: Text(
                          "لا توجد صور",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Container(
                      height: 600,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return PhotoView(
                              imageProvider: CachedNetworkImageProvider(
                            widget.images[index],
                          ));
                        },
                        itemCount: widget.images.length,
                        onIndexChanged: (value) {
                          setState(() {
                            _index = value + 1;
                          });
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
