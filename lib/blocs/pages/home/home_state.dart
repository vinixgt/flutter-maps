import 'dart:io' show Platform;
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng, Marker, MarkerId;


// ignore: must_be_immutable
class HomeState extends Equatable {

  final LatLng myLocation;
  final bool loading, gpsEnabled;
  Map<MarkerId, Marker> markers = Map();

  HomeState({this.myLocation, this.loading = true, this.markers, this.gpsEnabled});

  static HomeState get initialState => HomeState(
    myLocation: null,
    loading: true,
    markers: Map(),
    gpsEnabled: Platform.isIOS,
  );

  HomeState copyWith({
    LatLng myLocation,
    bool loading,
    bool gpsEnabled,
    Map<MarkerId, Marker> markers,
  }) {
    return HomeState(
      myLocation: myLocation ?? this.myLocation,
      loading: loading ?? this.loading,
      markers: markers ?? this.markers,
      gpsEnabled: gpsEnabled ?? this.gpsEnabled
    );
  }

  @override
  List<Object> get props => [
    myLocation,
    loading,
    markers,
    gpsEnabled
  ];
}