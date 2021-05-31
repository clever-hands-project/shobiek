import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Bloc/chat_bloc.dart';
import 'package:shobek/src/Helpers/map_helper.dart';
import 'package:shobek/src/MainScreens/Chat/Widgets/DriverActiveOrder.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/finishPay.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/internal/help.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/Models/DriverModel/DriverOrderModle.dart';
import 'package:shobek/src/Provider/DriverProvider/driverFinishOrderProvider.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:url_launcher/url_launcher.dart';

class PopupWidget extends StatefulWidget {
  final String phone;
  final int orderID;
  final int driverID;
  final String billPrice;
  final DriverOrder driverOrder;

  const PopupWidget(
      {Key key, this.phone, this.orderID, this.driverID, this.billPrice, this.driverOrder})
      : super(key: key);

  @override
  _PopupWidgetState createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  Position _startPosition;

  @override
  void initState() {
    MapHelper().getLocation().then((value) {
      setState(() {
        _startPosition = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: onselectpop,
      itemBuilder: (_) => [
        PopupMenuItem(
          enabled: true,
          value: 0,
          child: Text(
            'إرسال شكوى',
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
        ),
        PopupMenuItem(
          enabled: true,
          value: 1,
          child: Text(
            'اتصال',
            style: TextStyle(color: Colors.black, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ),
        // PopupMenuItem(
        //   enabled: true,
        //   value: 2,
        //   child: Text(
        //     'إرسال الموقع',
        //     style: TextStyle(color: Colors.black, fontSize: 13),
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        Provider.of<AuthController>(context,listen: false).userModel.data.type == 1?
        PopupMenuItem(
          enabled: true,
          value: 3,
          child: Text(
            'دفع اونلاين',
            style: TextStyle(color: Colors.black, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ):null,
        Provider.of<AuthController>(context,listen: false).userModel.data.type == 2?
        PopupMenuItem(
          enabled: true,
          value: 4,
          child: Text(
            'استلام كاش',
            style: TextStyle(color: Colors.black, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ):null,
        Provider.of<AuthController>(context,listen: false).userModel.data.type==2?
         PopupMenuItem(
          enabled: true,
          value: 5,
          child: Text(
            'تفاصيل الطلب',
            style: TextStyle(color: Colors.black, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ):null
      ],
    );
  }

  onselectpop(v) {
    switch (v) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HelpCenter(
              orderId: widget.orderID,
            )));
        break;
      case 1:
        launch("tel://${widget.phone}");
        break;
      case 2:
        sendMyLocaion();

        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FinishPay(
                      orderID: widget.orderID,
                    )));

        break;
      case 4:
        Provider.of<DriverFinishOrderProvider>(context, listen: false)
            .finishOrder(widget.orderID, context);
        break;
        case 5:
        if(widget.driverOrder != null )
        Navigator.push(context, MaterialPageRoute(builder: (c)=>DriverActiveOrder(
          driverOrderModle: widget.driverOrder,
        )));
        break;
      default:
    }
  }

  sendMyLocaion() {
    showBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 120,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.close,
                                size: 28, color: Colors.white)),
                        Text('موقع الإستلام',
                            style: TextStyle(color: Colors.white, fontSize: 17))
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 180,
                  width: MediaQuery.of(context).size.width,
                  child: _startPosition == null
                      ? Center(
                          child: SpinKitThreeBounce(
                            color: Theme.of(context).primaryColor,
                            size: 25,
                          ),
                        )
                      : Stack(
                          children: <Widget>[
                            GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(_startPosition.latitude,
                                    _startPosition.longitude),
                                zoom: 14.0,
                              ),
                              onCameraMove: (camera) {
                                chatBloc.updateLat(
                                    camera.target.latitude.toString());
                                chatBloc.updateLong(
                                    camera.target.longitude.toString());
                              },
                              gestureRecognizers:
                                  <Factory<OneSequenceGestureRecognizer>>[
                                new Factory<OneSequenceGestureRecognizer>(
                                  () => new EagerGestureRecognizer(),
                                ),
                              ].toSet(),
                            ),
                            Center(
                                child: Image.asset('assets/images/loc.png',
                                    width: 40)),
                            Positioned(
                              right: 15,
                              left: 15,
                              bottom: 15,
                              child: ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(10),
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Image.asset('assets/images/loc.png',
                                                width: 30),
                                            SizedBox(width: 10),
                                            Text('العنوان',
                                                style: TextStyle(
                                                    color: Colors.grey))
                                          ],
                                        ),
                                        TextField(
                                          onChanged: chatBloc.updateMsg,
                                          textAlign: TextAlign.right,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  fontSize: 15, height: .8)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  CustomBtn(
                                    color: Theme.of(context).primaryColor,
                                    onTap: () {
                                      // Navigator.pop(context);
                                      // chatBloc.add(SendMsg());
                                    },
                                    text: 'إرسال',
                                    txtColor: Colors.white,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                ),
              ],
            ),
          );
        });
  }
}
