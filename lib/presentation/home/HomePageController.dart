import 'dart:convert';

import 'package:cafe_app/presentation/profile/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;

import '../../models/Category.dart';
import '../../models/Product.dart';

class HomePageController extends GetxController {
  RxBool loaded = false.obs;
  RxString userName = "".obs;
  ProfileController profileController = Get.put(ProfileController());
  List<Category> categories = [];
  List<Product> allProducts = [];

  Future<void> onLoad(BuildContext context) async {
    loaded.value = false;
    await getCategories();
    await getAllProducts();
    await profileController.getUserData(context);
    userName.value = profileController.userData.name;
    initialCategoryName();
    getShared();
    loaded.value = true;
  }

  Future<void> getCategories() async{
    try{
      categories.clear();
      final response = await http.get(
        Uri.parse("${globals.url_base}api/categorias/obtenerCategoriasProducto")
      );

      if(response.statusCode != 200){
        loaded.value = true;
        return;
      }
      var body = json.decode(response.body);
      var list = body.map<Category>(Category.fromJson).toList();
      categories.addAll(list);

      loaded.value = true;
    }catch(e){
      print("ERROR: ${e}");
    }
  }

  Future<void> getAllProducts() async {
    try{
      allProducts.clear();
      final response = await http.get(
        Uri.parse("${globals.url_base}api/productos/traerTodosLosProductos")
      );

      if(response.statusCode != 200){
        return;
      }

      var body = json.decode(response.body).toList();
      for(var e in body as List){
        allProducts.add(Product.fromJson(e));
      }

    }catch(e){
      print("ERROR GET PRODUCTS: ${e}");
    }
  }

  void getShared() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("Token: ${sharedPreferences.getString("token")}");
  }
  /*List<Category> categories = getCategories();
  static List<Category> getCategories() {
    const categories = [
      {"id": 1, "name": "Hot Coffee"},
      {"id": 2, "name": "Iced Coffee"},
      {"id": 3, "name": "Chocolate"},
      {"id": 4, "name": "Signature"}
    ];
    return categories.map<Category>(Category.fromJson).toList();
  }*/

  /*List<Product> popular = getPopularProducts();

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
        ],
        "categoryId": 1
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
        ],
        "categoryId": 1
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
        ],
        "categoryId": 2
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
        ],
        "categoryId": 2
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
        ],
        "categoryId": 2
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
        ],
        "categoryId": 2
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
        ],
        "categoryId": 3
      },
      {
        "productId": "8",
        "name": "Premium coffee Signature",
        "price": "27.30",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355",
        "ingredients": [
          {"ingredientName": "Milk"},
          {"ingredientName": "Coffee"}
        ],
        "categoryId": 4
      }
    ];

    return data.map<Product>(Product.fromJson).toList();
  }*/

  var active = 0.obs;
  RxString categoryName = "".obs;
  RxInt selectedCategory = 1.obs;
  RxList filteredList = [].obs;

  void initialCategoryName(){
    filteredList.clear();
    categoryName.value = categories[0].name!;
    filteredList.addAll(allProducts.where((element) => element.categoryId! == selectedCategory.value));
  }

  void setCategoryName(String text) {
    categoryName.value = text;
  }

  void changeCategorySelected(int categoryId){
    selectedCategory.value = categoryId;
    filteredList.clear();
    filteredList.addAll(allProducts.where((element) => element.categoryId! == categoryId));
  }

}
