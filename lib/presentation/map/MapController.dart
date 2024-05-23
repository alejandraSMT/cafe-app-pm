import 'package:cafe_app/models/MapPoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
 List<MapPoint> mapPoints = placeholderMapPoints();
 List<Marker> markers = []; 
  
  @override
  void onInit() {
    super.onInit();
    markers = markersCreation(mapPoints);
  }
  
  List<Marker> markersCreation(List<MapPoint> points) {
    List<Marker> _marker = [];

    for (var element in points){
      var marker = Marker(
        markerId: MarkerId(element.id),
        position: LatLng(double.parse(element.latitude),double.parse(element.longitude)),
        infoWindow: InfoWindow(
          title: element.name
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
        );
        _marker.add(marker);
    }

    return _marker;
  }
  
  static List<MapPoint> placeholderMapPoints() {
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
}