import 'dart:convert';

import 'package:cafe_app/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;

class ProfileController extends GetxController{
  var userData = User();
  RxBool loaded = false.obs;
  RxBool editing = false.obs;
  Future<void> getUserData(BuildContext context) async{
    loaded.value = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    final response = await http.get(
          Uri.parse('${globals.url_base}api/usuario/getDatosUsuario'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      userData = User.fromJson(jsonDecode(response.body));
    loaded.value = true;
  }

  void changeEditingState(){
    editing.value = !editing.value;
  }

  void logout(BuildContext context) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    context.goNamed("login");
  }

}