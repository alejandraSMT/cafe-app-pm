import 'dart:convert';
import 'dart:ffi';

import 'package:cafe_app/presentation/home/HomePageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxString message = "".obs;
  var messageColor = Colors.green.obs;
  RxBool checkedBox = false.obs;

  HomePageController homePageController = Get.put(HomePageController());

  Future<void> login(BuildContext context) async{
    try{
      String email = emailController.text;
      String pass = passController.text;
      SharedPreferences sp = await SharedPreferences.getInstance();
      final response = await http.get(
          Uri.parse('${globals.url_base}api/usuario/iniciarSesion?emailAddress=${email}&contraseña=${pass}'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        saveToken(json.decode(response.body));
        if(checkedBox.isTrue){
          sp.setBool("isLogged", true);
        }
        context.goNamed("main");
      } else {
        sendError(response.body.toString());
        throw Exception('Failed to login: ${response.body}');
      }
      /*if(email=="123" && pass == "123"){
        context.goNamed("main");
      }else{
        message.value = "User not found";
        messageColor.value = Colors.red;
      }
      Future.delayed(Duration(seconds: 5), () {
        message.value = '';
      });*/
    }catch(e){
      print(e);
    }

  }

  void changeCheckboxValue(){
    print("value of checkbox: ${checkedBox.value}");
    checkedBox.value = !checkedBox.value;
  }

  void sendError(String text) {
    message.value = text;
    messageColor.value = Colors.red;
    Future.delayed(Duration(seconds: 5), () {
        message.value = '';
      });
  }

  void saveToken(data) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", data['token']);
  }

}