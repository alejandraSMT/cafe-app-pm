import 'dart:convert';

import 'package:cafe_app/models/CardItem.dart';
import 'package:cafe_app/models/Cards.dart';
import 'package:cafe_app/presentation/order-detail/OrderDetailController.dart';
import 'package:get/get.dart';import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;

class SelectPaymentController extends GetxController{

  List<CardItem> cardsList = [];
  RxBool loaded = false.obs;
  OrderDetailController orderDetailController = Get.put(OrderDetailController());

  Future<void> getUsersCards() async{
    try{

      loaded.value = false;
      cardsList.clear();

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      final response = await http.get(
          Uri.parse('${globals.url_base}api/tarjeta/obtenerTarjetasUsuario'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      
      if(response.statusCode == 200){
        final body = json.decode(response.body)['tarjetas'].toList();
        for(var e in body as List){
          cardsList.add(CardItem.fromJson(e));
        }
      }

      loaded.value = true;

    }catch(e){
      loaded.value = true;
      print(e);
    }
  }

  void selectCard(int idCard){
    orderDetailController.cardSelected.value = idCard;
    orderDetailController.cardInfo.value = cardsList.where((e) => e.id == idCard).first.cardNumber!;
    orderDetailController.paymentMethod.value = 1;
  }

  void cashOnSelected(){
    orderDetailController.cardSelected.value = (-1);
    orderDetailController.paymentMethod.value = 0;
  }

}