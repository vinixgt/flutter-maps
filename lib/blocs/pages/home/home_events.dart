import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

abstract class HomeEvents {}

class OnMyLocationUpdate extends HomeEvents {
  final LatLng location;
  OnMyLocationUpdate(this.location){}
}