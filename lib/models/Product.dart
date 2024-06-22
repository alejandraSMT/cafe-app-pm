import 'dart:ffi';

import 'package:cafe_app/models/Ingredient.dart';
import 'package:cafe_app/models/SizeCup.dart';
import 'package:flutter/cupertino.dart';
import 'Ingredient.dart';
import 'SizeCup.dart';

class Product {
  int? productId = -1;
  String? name = "";
  String? description = "";
  String? image = "";
  double? price = 0;
  List<Ingredient>? ingredients = [];
  List<SizeCup>? sizes = [];
  String? cant = "0";
  int? categoryId = -1;

  Product(
      {this.productId,
      this.name,
      this.description,
      this.image,
      this.price,
      this.ingredients,
      this.sizes,
      this.cant,
      this.categoryId});

  Product.fromJson(Map<dynamic, dynamic> json) {
    productId = json['id'];
    name = json['Nombre'];
    description = json['Descripcion'];
    image = json['Imagen'];
    price = double.parse(json['Precio'].toString());
    if (json['ingredientes'] != null) {
        ingredients = <Ingredient>[];
        for (var element in (json['ingredientes'] as List)) {
          ingredients!.add(Ingredient.fromJson(element));
        }
      }
    /*sizes = json['size'] != null ? SizeCup.fromJson(json['size']) as List<SizeCup>? : [];*/
    cant = json['cant'] ?? "0";
    categoryId = json['categoriaId'];
  }
}
