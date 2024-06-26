import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/models/MapPoint.dart';
import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/presentation/common/LoadingIndicator.dart';
import 'package:cafe_app/presentation/map/MapController.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  static const LatLng _center =
      const LatLng(37.42796133580664, -122.085749655962);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapController controller = Get.put(MapController());
  
  Completer<GoogleMapController> googleMapController = Completer();
  late GoogleMapController mapController;

  CameraPosition positionOfMap = CameraPosition(target:LatLng(-12.123134, -77.038200),zoom: 15.0);

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
        body: Obx(() => 
          controller.loaded.value ? 
          OrientationBuilder(builder: ((context, orientation) {
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
                          markers: Set<Marker>.of(controller.markers)
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
                            return GestureDetector(
                              onTap: () {
                                controller.changeMapPosition(positionOfMap, controller.storesList[index].latitude!, controller.storesList[index].longitude!);
                              },
                              child: Container(
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
                                                  controller.storesList[index].name,
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
                                                  controller.storesList[index].address!,
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
                                                    controller.storesList[index].hours!,
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
                                          child:  Image.network(
                                            controller.storesList[index].image!,
                                            fit: BoxFit.cover,
                                          ),
                                         ),
                                       ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder:(context, index) => Divider(thickness: 0,color: Colors.transparent),
                          itemCount: controller.storesList.length
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
                          markers: Set<Marker>.of(controller.markers)
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
                              return GestureDetector(
                                onTap: () {
                                controller.changeMapPosition(positionOfMap, controller.storesList[index].latitude!, controller.storesList[index].longitude!);
                                },
                                child: Container(
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
                                                    controller.storesList[index].name,
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
                                                    controller.storesList[index].address!,
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
                                                      controller.storesList[index].hours!,
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
                                            child:  Image.network(
                                              controller.storesList[index].image!,
                                              fit: BoxFit.cover,
                                            ),
                                           ),
                                         ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:(context, index) => Divider(thickness: 0,color: Colors.transparent),
                            itemCount: controller.storesList.length
                          ),
                        ),
                      )
                  ],
                ),
              ),
              
            );
          }
        })) : LoadingIndicator()
        ));
  }
}
