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

  void changeMapPosition(CameraPosition camPos, String lat, String lng) {
    camPos = CameraPosition(target: LatLng(double.parse(lat), double.parse(lng)), zoom: 15.0);
    print("Latitude $lat");
    print("Longitude: $lng");
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
      "hours":"Lun - Vie: 8:00 am - 10:00 pm",
      "image": "https://images.unsplash.com/photo-1559925393-8be0ec4767c8?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y2FmZSUyMGV4dGVyaW9yfGVufDB8fDB8fHww"
    },
    {
      "id": "2",
      "name":"Local 2",
      "latitude":"-12.1191136",
      "longitude": "-77.0358286",
      "address":"Av. Javier Prado 111",
      "hours":"Lun - Vie: 8:00 am - 10:00 pm",
      "image": "https://assets.simpleviewinc.com/simpleview/image/upload/c_limit,h_1200,q_75,w_1200/v1/clients/liverpool/Outdoor_Dining_In_Liverpool_37ab84aa-9615-44c8-951b-ff45bceecb70.png"
    },
    {
      "id": "3",
      "name":"Local 3",
      "latitude":"-12.1156956",
      "longitude": "-77.03017490040199",
      "address":"Av. Javier Prado 111",
      "hours":"Lun - Vie: 8:00 am - 10:00 pm",
      "image":"https://nextrestaurants.com/wp-content/uploads/2019/04/Restaurant-Outdoor-Design.png"
    }
    ];
    return data.map<MapPoint>(MapPoint.fromJson).toList();
  }
}