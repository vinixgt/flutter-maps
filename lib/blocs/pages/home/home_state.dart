import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng, Marker, MarkerId;


// ignore: must_be_immutable
class HomeState extends Equatable {

  final LatLng myLocation;
  final bool loading;
  Map<MarkerId, Marker> markers = Map();

  HomeState({this.myLocation, this.loading = true, this.markers});

  static HomeState get initialState => HomeState(
    myLocation: null,
    loading: true,
    markers: Map(),
  );

  HomeState copyWith({
    LatLng myLocation,
    bool loading,
    Map<MarkerId, Marker> markers,
  }) {
    return HomeState(
      myLocation: myLocation ?? this.myLocation,
      loading: loading ?? this.loading,
      markers: markers ?? this.markers
    );
  }

  @override
  List<Object> get props => [
    myLocation,
    loading,
    markers,
  ];
}