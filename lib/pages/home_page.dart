import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_maps/blocs/pages/home/bloc.dart';


class HomePage extends StatefulWidget {

  static const routeName = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //14.4843093,-90.6206226

  final HomeBloc _bloc = HomeBloc();

  

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: this._bloc,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (_, HomeState state) {
                if(!state.gpsEnabled) {
                  return Center(
                    child: Text(
                      'Debes activar el GPS para utilizar la app.',
                      textAlign: TextAlign.center,
                    )
                  );
                }
                if(state.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                    
                  );
                }
                final CameraPosition _initialPosition = CameraPosition(
                  target: state.myLocation,
                  zoom: 16,
                );
                return Stack(
                  children: <Widget>[
                    GoogleMap(
                      initialCameraPosition: _initialPosition,
                      zoomControlsEnabled: false,
                      compassEnabled: true,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        this._bloc.setMapController(controller);
                      },
                      onTap: (position) {
                        this._bloc.add(OnMapTap(position));
                      },
                      markers: state.markers.values.toSet(),
                      polylines: state.polylines.values.toSet(),
                      polygons: state.polygons.values.toSet(),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 15,
                      child: FloatingActionButton(
                        onPressed: _bloc.goToMyPosition,
                        child: Icon(
                          Icons.gps_fixed,
                          color: Colors.black
                        ),
                        backgroundColor: Colors.white,
                      )
                    )
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
} // class