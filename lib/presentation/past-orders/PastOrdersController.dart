import 'dart:convert';

import 'package:cafe_app/models/PastOrders.dart';
import 'package:get/get.dart';
import 'package:cafe_app/models/Order.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;

class PastOrdersController extends GetxController {
  List<PastOrders> pastOrders = [];
  RxBool loaded = false.obs;

  Future<void> onLoading() async {
    pastOrders.clear();
    await getPastOrders();
  }

  Future<void> getPastOrders() async{
    try{

      loaded.value = false;

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      final response = await http.get(
        Uri.parse("${globals.url_base}api/ordenRoutes/obtenerOrdenesPorUsuario"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }
      );

      if(response.statusCode != 200){
        print("Error getting past orders");
        loaded.value = true;
        return;
      }

      final body = json.decode(response.body).toList();
      for (var e in body as List) {
        pastOrders.add(PastOrders.fromJson(e));
      }

      print("body: $pastOrders");

      loaded.value = true;

    }catch(e){
      loaded.value = true;
      print("Error getting past orders: $e");
    }
  }

  /*void loadPastOrders() {
    final data = [
      {
        "number": "1",
        "date": "21/05/24",
        "payMethod": "Credit Card",
        "price": "100",
        "quantity": "4",
        "local": "Surco",
      },
      {
        "number": "2",
        "date": "22/05/24",
        "payMethod": "Cash",
        "price": "50",
        "quantity": "2",
        "local": "San Miguel",
      },
      {
        "number": "3",
        "date": "20/05/24",
        "payMethod": "Credit Card",
        "price": "150",
        "quantity": "5",
        "local": "Salamanca",
      },
      {
        "number": "4",
        "date": "21/05/24",
        "payMethod": "Cash",
        "price": "20",
        "quantity": "2",
        "local": "Surco",
      },
    ];
    pastOrders.addAll(data.map<Order>((json) => Order.fromJson(json)).toList());
  }*/
}