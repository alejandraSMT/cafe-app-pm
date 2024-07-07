import 'dart:convert';

import 'package:cafe_app/models/CardItem.dart';
import 'package:cafe_app/models/Cards.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;

class MyCardsController extends GetxController{

  List<CardItem> cardsList = [];
  RxBool loaded = false.obs;

  Future<void> onLoading() async{
    await getCardsList();
  }

  Future<void> getCardsList() async{
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
          },
      );

      if(response.statusCode != 200){
        loaded.value = true;
        return;
      }

      final body = json.decode(response.body)['tarjetas'].toList();
        for(var e in body as List){
          cardsList.add(CardItem.fromJson(e));
      }

      print("Cards list in : ${cardsList.length}");

      loaded.value = true;

    }catch(e){
      loaded.value = true;
      print(e);
    }
  }

  Future<void> deleteCard(int idCard) async{
    try{

      final response = await http.delete(
        Uri.parse("${globals.url_base}api/tarjeta/eliminarTarjeta?id=$idCard")
      );

      if(response.statusCode != 204){
        print("Error deleting card");
        return;
      }

      getCardsList();

    }catch(e){
      print("Error deleting card: $e");
    }
  }

}