import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../models/Category.dart';
import '../../models/Product.dart';

class HomePageController extends GetxController {
  List<Category> categories = getCategories();
  static List<Category> getCategories() {
    const categories = [
      {"id": 1, "name": "Hot Coffee"},
      {"id": 2, "name": "Iced Coffee"},
      {"id": 3, "name": "Chocolate"},
      {"id": 4, "name": "Signature"}
    ];
    return categories.map<Category>(Category.fromJson).toList();
  }

  List<Product> popular = getPopularProducts();

  static List<Product> getPopularProducts() {
    const data = [
      {
        "productId": "1",
        "name": "Honey almondmilk cold brew brew brew brew brew brew",
        "price": "14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355",
        "ingredients": [
          {"ingredientName": "Milk"},
          {"ingredientName": "Coffee"},
          {"ingredientName": "Coffee"},
          {"ingredientName": "Coffee"},
          {"ingredientName": "Coffee"},
          {"ingredientName": "Coffee"},
          {"ingredientName": "Milk"},
          {"ingredientName": "Coffee"},
          {"ingredientName": "Coffee"},
          {"ingredientName": "Coffee"},
          {"ingredientName": "Coffee"},
          {"ingredientName": "Coffee"},
        ],
        "sizes":[
          {"size":"Small"},
          {"size": "Medium"}
        ]
      },
      {
        "productId": "2",
        "name": "Honey almondmilk cold brew",
        "price": "14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355",
        "ingredients": [
          {"ingredientName": "Milk"},
          {"ingredientName": "Coffee"}
        ],
        "sizes":[
          {"size":"Small"}
        ]
      },
      {
        "productId": "3",
        "name": "Honey almondmilk cold brew",
        "price": "14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355",
        "ingredients": [
          {"ingredientName": "Milk"},
          {"ingredientName": "Coffee"}
        ],
        "sizes":[
          {"size":"Small"},
          {"size": "Medium"},
          {"size": "Large"}
        ]
      },
      
      {
        "productId": "4",
        "name": "Honey almondmilk cold brew",
        "price": "14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355",
        "ingredients": [
          {"ingredientName": "Milk"},
          {"ingredientName": "Coffee"}
        ]
      },
      
      {
        "productId": "5",
        "name": "Honey almondmilk cold brew",
        "price": "14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355",
        "ingredients": [
          {"ingredientName": "Milk"},
          {"ingredientName": "Coffee"}
        ]
      },
      {
        "productId": "6",
        "name": "Honey almondmilk cold brew",
        "price": "14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355",
        "ingredients": [
          {"ingredientName": "Milk"},
          {"ingredientName": "Coffee"}
        ]
      },
      
      {
        "productId": "7",
        "name": "Honey almondmilk cold brew",
        "price": "14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355",
        "ingredients": [
          {"ingredientName": "Milk"},
          {"ingredientName": "Coffee"}
        ]
      },
      
      {
        "productId": "8",
        "name": "Honey almondmilk cold brew",
        "price": "14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355",
        "ingredients": [
          {"ingredientName": "Milk"},
          {"ingredientName": "Coffee"}
        ]
      }
    ];
    return data.map<Product>(Product.fromJson).toList();
  }

  var active = 0.obs;
  RxString categoryName = "".obs;
  void setCategoryName(String text) {
    categoryName.value = text;
  }
}
