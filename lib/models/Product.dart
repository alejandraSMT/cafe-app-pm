import 'package:cafe_app/models/Ingredient.dart';
import 'package:cafe_app/models/SizeCup.dart';
import 'package:flutter/cupertino.dart';

class Product{
  String? name;
  String? description;
  String? image;
  String? price;
  List<Ingredient>? ingredients;
  List<SizeCup>? sizes;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.ingredients,
    this.sizes
  });

  Product.fromJson(Map<String,dynamic> json){
    name=json['name'];
    description=json['description']; 
    image=json['image'];
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
  }


}