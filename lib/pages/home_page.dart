import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_maps/utils/map_style.dart';
import '../utils/map_style.dart';


class HomePage extends StatefulWidget {

  static const routeName = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //14.4843093,-90.6206226

  final Completer<GoogleMapController> _completer = Completer();

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(14.4843093, -90.6206226),
    zoom: 16,
  );

  @override
  void initState() {
    super.initState();
    this._init();
    print('============ hola mundo.....');
  }

  Future <GoogleMapController> get _mapController async {
    return await _completer.future;
  }

  _init() async {
    (await _mapController).setMapStyle(jsonEncode(mapStyle));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          zoomControlsEnabled: false,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
            //controller.setMapStyle(jsonEncode(mapStyle));
          },
        )
      )
    );
  }
}