import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/Product.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  static const LatLng _center =
      const LatLng(37.42796133580664, -122.085749655962);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> googleMapController = Completer();
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Locales",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: OrientationBuilder(builder: ((context, orientation) {
          if (orientation == Orientation.portrait) {
            return Center(
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: 400),
                    child: GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        if(!googleMapController.isCompleted){
                          googleMapController.complete(controller);
                        }
                      },
                      initialCameraPosition: const CameraPosition(
                          target: LatLng(37.42796133580664, -122.085749655962),
                          zoom: 15.0),
                      mapType: MapType.normal,
                      zoomControlsEnabled: true,
                      compassEnabled: true,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Row(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        if(!googleMapController.isCompleted){
                          googleMapController.complete(controller);
                        }
                      },
                      initialCameraPosition: const CameraPosition(
                          target: LatLng(37.42796133580664, -122.085749655962),
                          zoom: 15.0),
                      mapType: MapType.normal,
                      zoomControlsEnabled: true,
                      compassEnabled: true,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                    ),
                  )
                ],
              ),
            );
          }
        })));
  }
}
