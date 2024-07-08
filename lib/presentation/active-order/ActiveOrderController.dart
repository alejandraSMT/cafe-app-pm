import 'dart:convert';

import 'package:cafe_app/models/OrderDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;

class ActiveOrderController extends GetxController{

  RxBool loaded = false.obs;
  Rx<OrderDetail> orderDetail = OrderDetail().obs;

  Future<void> getActiveOrderInfo(String orderId) async{
    try{
      loaded.value = false;
      orderDetail.value = OrderDetail();
      final response = await http.get(
        Uri.parse("${globals.url_base}api/ordenRoutes/obtenerOrdenPorId?ordenId=$orderId")
      );

      if(response.statusCode != 200){
        loaded.value = true;
        return;
      }
      
      var body = OrderDetail.fromJson(jsonDecode(response.body));
      orderDetail.value = body;
      print("Order detail obtained: $orderDetail");

      loaded.value = true;

    }catch(e){
      loaded.value = true;
      print("Error getting active order info: $e");
    }
  }

  Future<void> changeOrderStatus(String orderId, BuildContext context) async{
    try{

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final response = await http.patch(
        Uri.parse("${globals.url_base}api/ordenRoutes/actualizarEstatusOrden?ordenId=$orderId")
      );

      if(response.statusCode != 200){
        print("Error updating status of order");
        return;
      }
      
      sharedPreferences.setBool("hasActiveOrder", false);
      context.pop();

    }catch(e){
      print(e);
    }

  }

}