import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/MapPoint.dart';
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

  CameraPosition positionOfMap = CameraPosition(target:LatLng(-12.123134, -77.038200),zoom: 15.0);

List<MapPoint> mapPoints = getMapPoints();

  static List<MapPoint> getMapPoints() {
    const data = [
      {
      "id": "1",
      "name":"Local 1",
      "latitude":"-12.1183458",
      "longitude": "-77.0407428",
      "address":"Av. Javier Prado 111",
      "hours":"Lun - Vie: 8:00 am - 10:00 pm"
    },
    {
      "id": "2",
      "name":"Local 2",
      "latitude":"-12.1191136",
      "longitude": "-77.0358286",
      "address":"Av. Javier Prado 111",
      "hours":"Lun - Vie: 8:00 am - 10:00 pm"
    },
    {
      "id": "3",
      "name":"Local 3",
      "latitude":"-12.1156956",
      "longitude": "-77.03017490040199",
      "address":"Av. Javier Prado 111",
      "hours":"Lun - Vie: 8:00 am - 10:00 pm"
    }
    ];
    return data.map<MapPoint>(MapPoint.fromJson).toList();
  }
  List<Marker> _marker = [];

  @override
  void initState() {
    mapPoints.toList().forEach((element) {
      var marker = Marker(
        markerId: MarkerId(element.id),
        position: LatLng(double.parse(element.latitude),double.parse(element.longitude)),
        infoWindow: InfoWindow(
          title: element.name
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
        );
        _marker.add(marker);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Stores",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: OrientationBuilder(builder: ((context, orientation) {
          if (orientation == Orientation.portrait) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        constraints: BoxConstraints(maxHeight: 350),
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            if (!googleMapController.isCompleted) {
                              googleMapController.complete(controller);
                            }
                          },
                          initialCameraPosition: positionOfMap,
                          mapType: MapType.normal,
                          zoomControlsEnabled: true,
                          compassEnabled: true,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          markers: Set<Marker>.of(_marker)
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder:(context, index) {
                            return Container(
                              constraints: BoxConstraints(maxWidth: 350, minWidth: 300),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                mapPoints[index].name,
                                                style: TextStyle(
                                                  fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500
                                                )
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Address: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500)
                                              ),
                                              Text(
                                                mapPoints[index].address,
                                                style: TextStyle(
                                                  fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.visible,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  mapPoints[index].hours,
                                                  style: TextStyle(
                                                    fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                                                    color: Colors.grey
                                                  ),
                                                  overflow: TextOverflow.visible,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                     Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                                     Expanded(
                                       child: Container(
                                        constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                                        child:  Placeholder(),
                                       ),
                                     ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder:(context, index) => Divider(thickness: 0,color: Colors.transparent),
                          itemCount: mapPoints.length
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 400),
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            if (!googleMapController.isCompleted) {
                              googleMapController.complete(controller);
                            }
                          },
                          initialCameraPosition: positionOfMap,
                          mapType: MapType.normal,
                          zoomControlsEnabled: true,
                          compassEnabled: true,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          markers: Set<Marker>.of(_marker)
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 200),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder:(context, index) {
                              return Container(
                                constraints: BoxConstraints(maxWidth: 350, minWidth: 300),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  mapPoints[index].name,
                                                  style: TextStyle(
                                                    fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500
                                                  )
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Address: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500)
                                                ),
                                                Text(
                                                  mapPoints[index].address,
                                                  style: TextStyle(
                                                    fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                                                    color: Colors.black,
                                                  ),
                                                  overflow: TextOverflow.visible,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    mapPoints[index].hours,
                                                    style: TextStyle(
                                                      fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                                                      color: Colors.grey
                                                    ),
                                                    overflow: TextOverflow.visible,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                       Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                                       Expanded(
                                         child: Container(
                                          constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                                          child:  Placeholder(),
                                         ),
                                       ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:(context, index) => Divider(thickness: 0,color: Colors.transparent),
                            itemCount: mapPoints.length
                          ),
                        ),
                      )
                  ],
                ),
              ),
              
            );
          }
        })));
  }
}
