// ignore: unused_import
import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/Product.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'presentation/HomePage.dart';
import 'presentation/MapView.dart';
import 'presentation/Profile.dart';
import 'package:cafe_app/presentation/SignUp.dart';
//import 'package:device_preview/device_preview.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = ThemeData(
      colorSchemeSeed: Color.fromARGB(255, 177, 127, 77),
    );

    return MaterialApp(
      theme: appTheme,
      home: const Scaffold(
        body: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int currentPage = 0;

  Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (currentPage) {
      case 0:
        page = const HomePage();
        break;

      case 1:
        page = MapView();
        break;
      case 2:
        page = Profile();

      default:
        throw UnimplementedError("no widget for $currentPage");
    }

    return Scaffold(
      body: SafeArea(child: page),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => {
          setState(() {
            currentPage = value;
          })
        },
        selectedIndex: currentPage,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.map), label: "Map"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}