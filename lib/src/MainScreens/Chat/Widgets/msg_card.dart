import 'package:bubble/bubble.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/text_helper.dart';
import 'package:shobek/src/Models/chat/msg_model.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';

import 'circleImage.dart';

class MsgCard extends StatefulWidget {
  final MsgModel model;

  const MsgCard({Key key, this.model}) : super(key: key);

  @override
  _MsgCardState createState() => _MsgCardState();
}

class _MsgCardState extends State<MsgCard> {
  // Set<Marker> markers = Set();
  // Marker _addressMarker;
  // _addMarker() async {
  //   _addressMarker = Marker(
  //     markerId: MarkerId('address'),
  //     position: LatLng(double.parse(widget.model.latitude),
  //         double.parse(widget.model.longitude)),
  //     infoWindow: InfoWindow(title: 'العنوان'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(
  //       BitmapDescriptor.hueRed,
  //     ),
  //   );
  //   setState(() {
  //     markers.add(_addressMarker);
  //   });
  // }
  int usertype;
  @override
  void initState() {
    // if (widget.model.latitude != null) {
    //   // _addMarker();
    // }/
    Provider.of<AuthController>(context, listen: false).userModel.data.type == 1
        ? usertype = 2
        : usertype = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<AuthController>(context, listen: false).userModel.data.id ==
        widget.model.userId) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleUserImage(
                userPhoto: widget.model.userPhoto ?? "",
                errorPhoto: Provider.of<AuthController>(context, listen: false)
                            .userModel
                            .data
                            .type ==
                        1
                    ? "assets/images/person.png"
                    : "assets/images/dil.png",
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Bubble(
                    margin: BubbleEdges.all(1),
                    // nip: BubbleNip.rightBottom,
                    color: Theme.of(context).accentColor,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Text(
                            widget.model.message == "null" ||
                                    widget.model.message == null
                                ? ""
                                : widget.model.message,
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.white)),
                        widget.model.file != null
                            ? InkWell(
                                // onTap: () => Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (c) => PhotoGallaryString(
                                //             images: chatBloc.images))),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network(
                                    widget.model.file,
                                    height: 200,
                                  ),
                                ),
                              )
                            : Container(),
                        // widget.model.latitude != null
                        //     ? Container(
                        //         height: 200,
                        //         child: GoogleMap(
                        //           markers: markers,
                        //           initialCameraPosition: CameraPosition(
                        //             target: LatLng(
                        //                 double.parse(widget.model.latitude),
                        //                 double.parse(widget.model.longitude)),
                        //             zoom: 14.0,
                        //           ),
                        //           gestureRecognizers:
                        //               <Factory<OneSequenceGestureRecognizer>>[
                        //             new Factory<OneSequenceGestureRecognizer>(
                        //               () => new EagerGestureRecognizer(),
                        //             ),
                        //           ].toSet(),
                        //         ),
                        //       )
                        //     : Container(),
                        Text(
                            TextHelper().formatDate(
                                date: DateTime.parse(widget.model.createdAt)),
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 11, color: Colors.white))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleUserImage(
                userPhoto: widget.model.userPhoto ?? "",
                errorPhoto: usertype == 1
                    ? "assets/images/person.png"
                    : "assets/images/dil.png",
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Bubble(
                    margin: BubbleEdges.all(1),
                    // nip: BubbleNip.leftBottom,
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Text(
                            widget.model.message == "null" ||
                                    widget.model.message == null
                                ? ""
                                : widget.model.message,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black)),
                        widget.model.file != null
                            ? InkWell(
                                // onTap: () => Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (c) => PhotoGallaryString(
                                //             images: chatBloc.images))),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network(
                                    widget.model.file,
                                    height: 200,
                                  ),
                                ),
                              )
                            : Container(),
                        // widget.model.latitude != null
                        //     ? Container(
                        //         height: 200,
                        //         child: GoogleMap(
                        //           initialCameraPosition: CameraPosition(
                        //             target: LatLng(
                        //                 double.parse(widget.model.latitude),
                        //                 double.parse(widget.model.longitude)),
                        //             zoom: 14.0,
                        //           ),
                        //           gestureRecognizers:
                        //               <Factory<OneSequenceGestureRecognizer>>[
                        //             new Factory<OneSequenceGestureRecognizer>(
                        //               () => new EagerGestureRecognizer(),
                        //             ),
                        //           ].toSet(),
                        //         ),
                        //       )
                        //     : Container(),
                        Text(
                            TextHelper().formatDate(
                                date: DateTime.parse(widget.model.createdAt)),
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 11, color: Colors.black))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
