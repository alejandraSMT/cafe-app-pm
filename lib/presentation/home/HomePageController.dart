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
  RxBool hasActiveOrder = false.obs;
  var activeOrderId = (-1);

  Future<void> onLoad(BuildContext context) async {
    loaded.value = false;
    hasActiveOrder.value = false;
    activeOrderId = -1;
    await profileController.getUserData(context);
    await getCategories();
    await getAllProducts();
    await getActiveOrder();
    userName.value = profileController.userData.name;
    initialCategoryName();
    getShared();
    loaded.value = true;
  }

  Future<void> getActiveOrder() async{
    try{

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      final response = await http.get(
        Uri.parse("${globals.url_base}api/ordenRoutes/obtenerOrdenActiva"),
         headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
      );

      if(response.statusCode != 200){
        sharedPreferences.setBool("hasActiveOrder", false);
        return;
      }

      hasActiveOrder.value = true;
      sharedPreferences.setBool("hasActiveOrder", true);
      activeOrderId = json.decode(response.body)["id"];

      print("ACTIVE ORDER: $activeOrderId");

    }catch(e){
      print("Error getting active order: $e");
    }
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
