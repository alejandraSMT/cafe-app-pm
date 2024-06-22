import 'package:cafe_app/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class OrderDetailController extends GetxController{
  List<Product> productsCart = getProductsCart();

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

  var stores = [
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
  ].toList();

  RxString selectedLocal = "".obs;

}