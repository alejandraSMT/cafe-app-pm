import 'dart:convert';

import 'package:cafe_app/models/CardItem.dart';
import 'package:cafe_app/models/Cards.dart';
import 'package:get/get.dart';import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;

class SelectPaymentController extends GetxController{

  List<CardItem> cardsList = [];
  RxBool loaded = false.obs;

  RxInt cardSelected = (-1).obs;
  RxInt paymentMethod = 0.obs;

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
        final body = json.decode(response.body);
        var cardInstance = Cards.fromJson(body);

        if(cardInstance.cards != null){
          cardsList.addAll(cardInstance.cards!);
        }
      }

      loaded.value = true;

    }catch(e){
      loaded.value = true;
      print(e);
    }
  }

  void selectCard(int idCard){
    cardSelected.value = idCard;
    paymentMethod.value = 1;
  }

  void cashOnSelected(){
    cardSelected.value = (-1);
    paymentMethod.value = 0;
  }

}