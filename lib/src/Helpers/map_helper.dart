import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart' as loc;

class MapHelper with ChangeNotifier {
  Position position = Position(latitude: 399.00, longitude: 3044.33);
  String address = "انقر لتحديث موقعك";
  bool loading = false;
  MapType mapType = MapType.normal;
  var location = loc.Location();
  Position currentLocation;
  getLocation() async {
    if (!await location.serviceEnabled())
      await location.requestService().then((value) async{
        print("requestService $value");
        if (value != false) {
          try {
            loading = true;
          await  currentLocat();
          } catch (e) {
            print("error $e");
            currentLocation = null;
          }
        }
      });
    else {
      try {
        loading = true;
        currentLocat();
      } catch (e) {
        print("error $e");
        currentLocation = null;
      }
    }
  }

  currentLocat() async {
    currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    print(currentLocation.toString());

    position = currentLocation;
    final coordinates =
        new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print('1 ${first.locality} '
        "2 ${first.adminArea} "
        "3 ${first.subLocality} "
        "4 ${first.subAdminArea} "
        "5 ${first.addressLine} "
        "6 ${first.featureName} "
        "7 ${first.thoroughfare} "
        "8 ${first.subThoroughfare} ");
    address = first.featureName.length > 25
        ? ".." + first.featureName.substring(0, 25)
        : first.featureName;
    loading = false;
    notifyListeners();
  }

  changeMapType(MapType m) {
    mapType = m;
    notifyListeners();
  }
}
