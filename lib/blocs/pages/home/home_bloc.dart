import 'dart:async';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_maps/utils/extras.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'home_events.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  
  Geolocator _geolocator = Geolocator();
  final Completer<GoogleMapController> _completer = Completer();

  final LocationOptions _locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  StreamSubscription<Position> _subscription;

  Future <GoogleMapController> get _mapController async {
    return await _completer.future;
  }

  
  HomeBloc() {
    this._init();
  }

  Future<void> setMapController(GoogleMapController controller) async {
    if(!_completer.isCompleted) {
      _completer.complete(controller);
      //(await _mapController).setMapStyle(jsonEncode(mapStyle));
    }
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    super.close();
  }

  _init() async {
    _subscription = _geolocator.getPositionStream(_locationOptions).listen((Position position) { 
      if(position != null) {
        add(OnMyLocationUpdate(LatLng(position.latitude, position.longitude)));
      }
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  HomeState get initialState => HomeState.initialState;

  @override
  Stream<HomeState> mapEventToState(HomeEvents event) async* {
      if(event is OnMyLocationUpdate) {
    
        yield this.state.copyWith(
          myLocation: event.location,
          loading: false
        );
      } else if (event is OnMapTap) {
        final markerId = MarkerId(this.state.markers.length.toString());
        final info = InfoWindow(
          title: 'Hello world ${markerId.value}',
          snippet: 'La direccion etc.',
        );
        final Uint8List pinImage = await loadAsset('assets/car-pin.png', height: 100, width: 50);
        final customIcon = BitmapDescriptor.fromBytes(pinImage);
        final marker = Marker(
          markerId: markerId,
          position: event.location,
          onTap: (){
            print('################################# hola a todos los pines $markerId.value');
          },
          draggable: true,
          onDragEnd: (newPosition) {
            print('```````````````````````` ${markerId.value} new position $newPosition');
          },
          infoWindow: info,
          icon: customIcon,
          anchor: Offset(0.5, 0.5),
        );

        final markers = Map<MarkerId, Marker>.from(this.state.markers);
        markers[markerId] = marker;
        yield this.state.copyWith(markers: markers);
      }
  }
}