import 'package:flutter/material.dart';
import 'package:flutter_maps/pages/home_page.dart';
import 'package:flutter_maps/pages/request_permission_page.dart';
import 'package:flutter_maps/pages/splash_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      routes: {
        HomePage.routeName: (_)=>HomePage(),
        RequestPermissionPage.routeName: (_)=>RequestPermissionPage(),
      }
    );
  }
}
