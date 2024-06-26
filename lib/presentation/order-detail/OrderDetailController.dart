import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/models/Store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;

class OrderDetailController extends GetxController{
  List<Product> productsCart = getProductsCart();
  List<Store> stores = [];
  RxBool loaded = false.obs;

  Future<void> onLoading() async{
    stores.clear();
    await getStores();
  }

  static List<Product> getProductsCart() {
    const data = [
      {
        "Nombre": "Honey almondmilk cold brew",
        "Precio": 14.25,
        "sizes":[
          {"size": "Medium"}
        ],
        "cant":"2"
      },
      {
        "Nombre": "Honey almondmilk cold brew",
        "Precio": 14.25,
        "sizes":[
          {"size": "Medium"}
        ],
        "cant":"1"
      }
    ];
    return data.map<Product>(Product.fromJson).toList();
  }

  /*var stores = [
    {
      "localId": "1",
      "name": "Local 1"
    },
    {
      "localId": "2",
      "name": "Local 2"
    },
    {
      "localId": "3",
      "name": "Local 3"
    }
  ].toList();*/

  Future<void> getStores() async { 
    try{
      loaded.value = false;
      final response = await http.get(
        Uri.parse("${globals.url_base}api/local/listaLocales")
      );

      if(response.statusCode != 200){
        print("error getting stores!");
        return;
      }

      var body = json.decode(response.body)['locales'].toList();
      for(var e in body as List){
        stores.add(Store.fromJson(e));
      }

      loaded.value = true;

    }catch(e){
      loaded.value = true;
      print(e);
    }
  }

  RxInt selectedLocal = (-1).obs;

}