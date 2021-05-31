import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as locat;
import 'package:shobek/src/Helpers/map_helper.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/MainWidgets/mapFabs.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Provider/get/MyAddressProvider.dart';
import 'package:shobek/src/Provider/post/createPlaceProvider.dart';
import 'package:shobek/src/Provider/post/editPlaceProvider.dart';
import 'package:shobek/src/Repository/appLocalization.dart';

class PickPlace extends StatefulWidget {
  final String initPlace;
  final String id;

  const PickPlace({Key key, this.initPlace, this.id}) : super(key: key);
  @override
  _PickPlaceState createState() => _PickPlaceState();
}

class _PickPlaceState extends State<PickPlace> {
  SharedPreferences _pref;
  String searchAddr;
  GoogleMapController _mapController;
  Set<Marker> _markers = Set();
  Marker _shopMarker;
  int count = 0;
  int indss = 0;
  double lat;
  double long;
  CustomDialog dialog = CustomDialog();

  var location = locat.Location();
  Future _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    } else {}
  }

  creatPlace() {
    Provider.of<CreatePlaceProvider>(context, listen: false).latitude =
        Provider.of<AuthController>(context, listen: false).lat.toString();
    Provider.of<CreatePlaceProvider>(context, listen: false).longitude =
        Provider.of<AuthController>(context, listen: false).long.toString();
  }

  editPlace() {
    Provider.of<EditPlaceProvider>(context, listen: false).latitude =
        Provider.of<AuthController>(context, listen: false).lat.toString();
    Provider.of<EditPlaceProvider>(context, listen: false).longitude =
        Provider.of<AuthController>(context, listen: false).long.toString();
  }

  @override
  void initState() {
    super.initState();
    creatPlace();
    editPlace();
    _checkGps();
  }

  BitmapDescriptor _pinLocationIcon;

  searchandNavigate() {
    Geocoder.local.findAddressesFromQuery(searchAddr).catchError((e) {
      setState(() {});
      CustomAlert().toast(
          context: context, title: localization.text("enter_correct_location"));
    });

 Geocoder.local.findAddressesFromQuery(searchAddr).then((result) {
      setState(() {});

      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  result[0].coordinates.latitude, result[0].coordinates.longitude),
              zoom: 10.0)));
    });
  }

  MapType _currentMapType = MapType.normal;
  void _onToggleMapTypePressed() {
    final MapType nextType =
        MapType.values[(_currentMapType.index + 1) % MapType.values.length];

    setState(() => _currentMapType = nextType);
  }

  bool isMarked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: <Widget>[
      //       Text(
      //         " الخريطة",
      //         style: TextStyle(color: Colors.white),
      //       ),
      //     ],
      //   ),
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      appBar: defaultAppBar(
        context: context,
        title: "الخريطة",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      body: Stack(
        children: <Widget>[
          Provider.of<MapHelper>(context, listen: false).position == null
              ? SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                  size: 25,
                )
              : Stack(
                  children: <Widget>[
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      myLocationEnabled: false,
                      mapType: _currentMapType,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            Provider.of<MapHelper>(context, listen: false)
                                .position
                                .latitude,
                            Provider.of<MapHelper>(context, listen: false)
                                .position
                                .longitude),
                        zoom: 14.0,
                      ),
                      onCameraMove: (camera) {
                        Provider.of<CreatePlaceProvider>(context, listen: false)
                            .latitude = camera.target.latitude.toString();
                        Provider.of<CreatePlaceProvider>(context, listen: false)
                            .longitude = camera.target.longitude.toString();
                        Provider.of<EditPlaceProvider>(context, listen: false)
                            .latitude = camera.target.latitude.toString();
                        Provider.of<EditPlaceProvider>(context, listen: false)
                            .longitude = camera.target.longitude.toString();
                      },
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(
                          () => new EagerGestureRecognizer(),
                        ),
                      ].toSet(),
                    ),
                    Center(
                        child: Image.asset('assets/images/loc.png', width: 40)),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset('assets/images/loc.png',
                                        width: 30),
                                    SizedBox(width: 10),
                                    Text('العنوان',
                                        style: TextStyle(color: Colors.grey))
                                  ],
                                ),
                                TextFormField(
                                  onChanged: (v) {
                                    Provider.of<CreatePlaceProvider>(context,
                                            listen: false)
                                        .placeName = v;
                                    Provider.of<EditPlaceProvider>(context,
                                            listen: false)
                                        .placeName = v;
                                  },
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.text,
                                  initialValue: widget.initPlace,
                                  decoration: InputDecoration(
                                      hintStyle:
                                          TextStyle(fontSize: 15, height: .8),
                                      hintText: "العنوان"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                           Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset('assets/images/loc.png',
                                        width: 30),
                                    SizedBox(width: 10),
                                    Text('تفاصيل العنوان',
                                        style: TextStyle(color: Colors.grey))
                                  ],
                                ),
                                TextFormField(
                                  onChanged: (v) {
                                    Provider.of<CreatePlaceProvider>(context,
                                            listen: false)
                                        .placeDetails = v;
                                    Provider.of<EditPlaceProvider>(context,
                                            listen: false)
                                        .placeDetails = v;
                                  },
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.text,
                                  initialValue: widget.initPlace,
                                  decoration: InputDecoration(
                                      hintStyle:
                                          TextStyle(fontSize: 15, height: .8),
                                      hintText: "تفاصيل العنوان"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          CustomBtn(
                            color: Theme.of(context).primaryColor,
                            onTap: () {
                              if (widget.initPlace == null) {
                                if (Provider.of<CreatePlaceProvider>(context,
                                            listen: false)
                                        .placeName ==
                                    null) {
                                  CustomAlert().toast(
                                    context: context,
                                    title: "يجب اضافة اسم المكان",
                                  );

                                  return;
                                }
                                if (Provider.of<CreatePlaceProvider>(context,
                                            listen: false)
                                        .latitude ==
                                    null) {
                                  CustomAlert().toast(
                                    context: context,
                                    title: "يجب اضافة موقع المكان",
                                  );
                                  return;
                                }
                                Provider.of<CreatePlaceProvider>(context,
                                        listen: false)
                                    .createPlace(context)
                                    .then((v) {
                                  if (v == true) {
                                    Provider.of<MyAddressProvider>(context,
                                            listen: false)
                                        .getPlaces();
                                    Navigator.pop(context);
                                  }
                                });
                              } else {
                                if (Provider.of<EditPlaceProvider>(context,
                                            listen: false)
                                        .placeName ==
                                    null) {
                                  CustomAlert().toast(
                                    context: context,
                                    title: "يجب اضافة اسم المكان",
                                  );

                                  return;
                                }
                                if (Provider.of<EditPlaceProvider>(context,
                                            listen: false)
                                        .latitude ==
                                    null) {
                                  CustomAlert().toast(
                                    context: context,
                                    title: "يجب اضافة موقع المكان",
                                  );
                                  return;
                                }
                                Provider.of<EditPlaceProvider>(context,
                                        listen: false)
                                    .createPlace(widget.id, context)
                                    .then((v) {
                                  if (v == true) {
                                    Provider.of<MyAddressProvider>(context,
                                            listen: false)
                                        .getPlaces();
                                    Navigator.pop(context);
                                  }
                                });
                              }
                            },
                            text: 'حفظ',
                            txtColor: Colors.black,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MapFabs(
                        myLocationButtonEnabled: true,
                        layersButtonEnabled: true,
                        onToggleMapTypePressed: _onToggleMapTypePressed,
                        onMyLocationPressed: () {
                          _checkGps();
                          _getLocation();
                        },
                      ),
                    ),
                  ],
                ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        textDirection:
                            localization.currentLanguage.toString() == "en"
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              textDirection:
                                  localization.currentLanguage.toString() ==
                                          "en"
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              textAlign:
                                  localization.currentLanguage.toString() ==
                                          "en"
                                      ? TextAlign.left
                                      : TextAlign.right,
                              textInputAction: TextInputAction.search,
                              onFieldSubmitted: (v) {
                                searchandNavigate();
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                hintText: localization.text("shearch"),
                              ),
                              onChanged: (v) {
                                setState(() {
                                  searchAddr = v;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: InkWell(
                                onTap: () {
                                  if (searchAddr == null ||
                                      searchAddr.length == 0) {
                                    CustomAlert().toast(
                                      context: context,
                                      title: localization
                                          .text("enter_correct_location"),
                                    );
                                    // Fluttertoast.showToast(
                                    //     msg: localization.text("enter_correct_location"),
                                    //     toastLength: Toast.LENGTH_LONG,
                                    //     timeInSecForIosWeb: 1,
                                    //     fontSize: 16.0);
                                    return;
                                  }
                                  setState(() {});
                                  searchandNavigate();
                                },
                                child: Icon(Icons.search)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Position> _getLocation() async {
    _pref = await SharedPreferences.getInstance();

    var currentLocation;
    try {
      currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print(currentLocation.toString());
      setState(() {
        _shopMarker = Marker(
          markerId: MarkerId('target'),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          infoWindow: InfoWindow(title: 'موقع التوصيل'),
          icon: _pinLocationIcon,
        );

        setState(() {
          _pref.setDouble("startLat", _shopMarker.position.latitude);
          _pref.setDouble("startLong", _shopMarker.position.longitude);
          lat = _shopMarker.position.latitude;
          long = _shopMarker.position.longitude;
          _markers.add(_shopMarker);
        });

        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(_shopMarker.position.latitude,
                    _shopMarker.position.longitude),
                zoom: 14.0)));
      });
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }
}
