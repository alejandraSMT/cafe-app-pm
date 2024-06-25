import 'dart:convert';

import 'package:cafe_app/models/MapPoint.dart';
import 'package:cafe_app/models/Store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;

class MapController extends GetxController {
 List<Store> storesList = [];
 RxBool loaded = false.obs;
 List<Marker> markers = []; 
  
  @override
  void onInit() {
    super.onInit();
    loadContent();
  }

  void loadContent() async {
    await getStores();
    markers = markersCreation(storesList);
  }

  Future<void> getStores() async{
    try{

      loaded.value = false;
      final response = await http.get(
        Uri.parse("${globals.url_base}api/local/traerTodosLosLocales")
      );

      if(response.statusCode != 200){
        return;
      }

      var body = json.decode(response.body).toList();
      for(var e in body as List){
        storesList.add(Store.fromJson(e));
      }

      loaded.value = true;

    }catch(e){
      loaded.value = true;
      print("Error MapController: $e");
    }
  }

  void changeMapPosition(CameraPosition camPos, double lat, double lng) {
    camPos = CameraPosition(target: LatLng(lat, lng), zoom: 15.0);
    print("Latitude $lat");
    print("Longitude: $lng");
  } 

  List<Marker> markersCreation(List<Store> points) {
    List<Marker> _marker = [];

    for (var element in points){
      var marker = Marker(
        markerId: MarkerId(element.id.toString()),
        position: LatLng(element.latitude,element.longitude),
        infoWindow: InfoWindow(
          title: element.name
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
        );
        _marker.add(marker);
    }

    return _marker;
  }

}