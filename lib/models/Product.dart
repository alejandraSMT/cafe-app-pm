import 'dart:ffi';

import 'package:cafe_app/models/Ingredient.dart';
import 'package:cafe_app/models/SizeCup.dart';
import 'package:flutter/cupertino.dart';

class Product{
  String? productId;
  String? name;
  String? description;
  String? image;
  String? price;
  List<Ingredient>? ingredients;
  List<SizeCup>? sizes;
  String? cant;
  int? categoryId;

  Product({
    required this.productId,
    required this.name,
    this.description,
    this.image,
    required this.price,
    this.ingredients,
    this.sizes,
    this.cant,
    this.categoryId
  });

  Product.fromJson(Map<String,dynamic> json){
    productId=json['productId'];
    name=json['name'];
    description=json['description']!=null ? json['description'] :  null; 
    image=json['image']!=null ? json['image'] : null;
    price=json['price'];
    if(json['ingredients'] != null){
      ingredients = <Ingredient>[];
      (json['ingredients'] as List).forEach((element) {
        ingredients!.add(Ingredient.fromJson(element));
      });
    }
    if(json['sizes']!=null){
      sizes = <SizeCup>[];
      (json['sizes'] as List).forEach((element) {
        sizes!.add(SizeCup.fromJson(element));
       });
    }
    cant = json['cant']!=null?json['cant']:null;
    categoryId=json['categoryId']!=null?json['categoryId']:null;
  }


}