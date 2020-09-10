import 'dart:io' show Platform;
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng, Marker, MarkerId, Polygon, PolygonId, Polyline, PolylineId;


// ignore: must_be_immutable
class HomeState extends Equatable {

  final LatLng myLocation;
  final bool loading, gpsEnabled;
  Map<MarkerId, Marker> markers = Map();
  Map<PolylineId, Polyline> polylines;
  Map<PolygonId, Polygon> polygons;

  HomeState({
    this.myLocation,
    this.loading = true,
    this.markers,
    this.gpsEnabled,
    this.polylines,
    this.polygons,
  });

  static HomeState get initialState => HomeState(
    myLocation: null,
    loading: true,
    markers: Map(),
    gpsEnabled: Platform.isIOS,
    polylines: Map(),
    polygons: Map(),
  );

  HomeState copyWith({
    LatLng myLocation,
    bool loading,
    bool gpsEnabled,
    Map<MarkerId, Marker> markers,
    Map<PolylineId, Polyline> polylines,
    Map<PolygonId, Polygon> polygons,
  }) {
    return HomeState(
      myLocation: myLocation ?? this.myLocation,
      loading: loading ?? this.loading,
      markers: markers ?? this.markers,
      gpsEnabled: gpsEnabled ?? this.gpsEnabled,
      polylines: polylines ?? this.polylines,
      polygons: polygons ?? this.polygons,
    );
  }

  @override
  List<Object> get props => [
    myLocation,
    loading,
    markers,
    gpsEnabled,
    polylines,
  ];
}