import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/models/CartDetail.dart';
import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/models/SizeCup.dart';
import 'package:cafe_app/models/Store.dart';
import 'package:cafe_app/presentation/cart/ShoppingCartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;

class OrderDetailController extends GetxController{
  //List<Product> productsCart = getProductsCart();
  List<CartDetail> cartProducts = [];
  List<Store> stores = [];
  RxString totalPrice = "0".obs;
  RxBool loaded = false.obs;

  RxInt cardSelected = (-1).obs;
  RxInt paymentMethod = (-1).obs;
  RxInt selectedLocal = (-1).obs;
  
  List<SizeCup> sizes = [];

  RxString cardInfo = "".obs;

  RxString message = "".obs;
  var messageColor = Colors.green.obs;

  Future<void> onLoading() async{
    cartProducts.clear();
    stores.clear();
    await setSizes();
    //reset();
    await getStores();
    await getItems();
  }

  Future<void> setSizes() async{
    const body = [
      {
        "id": 1,
        "size": "Small"
      },
      {
        "id": 2,
        "size": "Medium"
      },
      {
        "id": 3,
        "size": "Large"
      }
    ];
    sizes.addAll(body.map<SizeCup>(SizeCup.fromJson).toList());
  }
  
  void reset(){
    cardSelected.value = -1;
    paymentMethod.value = -1;
    selectedLocal.value = -1;
  }

  Future<void> getItems() async{
    try{
      loaded.value = false;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      final response = await http.get(
          Uri.parse(
              "${globals.url_base}api/carritoDetalle/obtenerCarritoConTodosLosDatos"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });

      if (response.statusCode != 200) {
        print("Error fetching cart data");
        return;
      }
      totalPrice.value = json.decode(response.body)['Total'].toString();
      final body = json.decode(response.body)['carritosDetalles'].toList();
      for (var e in body as List) {
        cartProducts.add(CartDetail.fromJson(e));
      }
      loaded.value = true;
    }catch(e){
      loaded.value = true;
      print("Error getting items: $e");
    }
  }

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

  Future<void> placeOrder(BuildContext context) async{
    try{

      

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      var hasActiveOrder = sharedPreferences.getBool("hasActiveOrder");
      

      Map body  = {
        "metodoDePago" : paymentMethod.value,
        "localId" : selectedLocal.value,
        "tarjetaId": cardSelected.value == -1 ? "" : cardSelected.value
      };

      print(body);

      if(paymentMethod.value == -1 || selectedLocal.value == -1){
        sendError("Select payment method and store");
        print("Cannot post");
        return;
      }

      if(hasActiveOrder!){
        sendError("You have an active order!");
        return;
      }

      final response = await http.post(
        Uri.parse("${globals.url_base}api/ordenRoutes/crearOrden"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(body)
      );

      if(response.statusCode != 201){
        sendError(response.body);
        print("Error creating order");
        return;
      }

      context.push("/orderConfirmation");
      reset();

    }catch(e){
      print("Error placing order: $e");
    }

  }

  void sendError(String text) {
    message.value = text;
    messageColor.value = Colors.red;
    Future.delayed(Duration(seconds: 5), () {
        message.value = '';
      });
  }

}