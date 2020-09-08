import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;


class HomeState extends Equatable {

  final LatLng myLocation;
  final bool loading;

  HomeState({this.myLocation, this.loading = true});

  HomeState copyWith({LatLng myLocation, bool loading}) {
    return HomeState(
      myLocation: myLocation??this.myLocation,
      loading: loading?? this.loading,
    );
  }

  @override
  List<Object> get props => [
    myLocation,
  ];
}