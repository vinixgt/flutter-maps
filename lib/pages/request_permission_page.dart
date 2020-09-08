import 'package:flutter/material.dart';
import 'dart:io' show Platform;


import 'package:flutter_maps/pages/home_page.dart';
import 'package:permission_handler/permission_handler.dart';


class RequestPermissionPage extends StatefulWidget {

  static const routeName = 'request-permission';
  @override
  _RequestPermissionPageState createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage> with WidgetsBindingObserver {
  
  bool _fromSettings = false;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('========== AppLifecycleState:::: $state');
    if(state == AppLifecycleState.resumed && _fromSettings) {
      this._check();
    }
  }

  _check() async {
    print('==================== AppLifecycleState ::::: chicking...');
    final bool hasAccess = await Permission.locationWhenInUse.isGranted;
    if(hasAccess) {
      this._goToHome();
    }
  }

  _goToHome() {
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  _openAppSettings() async {
    _fromSettings = true;
    await openAppSettings();
  }

  Future<void> _request() async {
    final PermissionStatus status = await Permission.locationWhenInUse.request();

    print("===== status $status");
    switch (status) {
      case PermissionStatus.undetermined:
        break;
      case PermissionStatus.granted:
        this._goToHome();
        break;
      case PermissionStatus.denied:
        if(Platform.isIOS) {
          this._openAppSettings();
        }
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.permanentlyDenied:
        this._openAppSettings();
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Permission Required',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              FlatButton(
                onPressed: this._request, 
                child: Text(
                  'Permit',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                color: Colors.blue,
              )
            ],
          )),
      ),
    );
  }
}