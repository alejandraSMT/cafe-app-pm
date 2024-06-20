import 'dart:convert';

import 'package:cafe_app/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;

class ProfileController extends GetxController {
  var userData = User();
  RxBool loaded = false.obs;
  RxBool editing = false.obs;
  RxString errorMessage = "".obs;
  TextEditingController lastname = TextEditingController(text: "Uwu");
  TextEditingController emailAddress = TextEditingController();
  Future<void> getUserData(BuildContext context) async {
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
    lastname.text = userData.lastname;
    emailAddress.text = userData.email;
    loaded.value = true;
  }

  void changeEditingState() {
    editing.value = !editing.value;
  }

  Future<void> updateChanges(BuildContext context) async {
    try {
      String lastnameUpdate = lastname.text;
      String emailUpdate = emailAddress.text;
      Map body = {'apellido': lastnameUpdate, 'emailAddress': emailUpdate};
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      if(isAllSpaces(lastnameUpdate) && isAllSpaces(emailUpdate)){
        sendError("Can not be empty.");
        return;
      }

      if(isAllSpaces(lastnameUpdate)){
        sendError("Last name not provided.");
        return;
      }

      if(isAllSpaces(emailUpdate)){
        sendError("Email not provided");
        return;
      }

      final response = await http.post(
            Uri.parse("${globals.url_base}api/usuario/modificarDatosUsuario"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode(body));
        if (response.statusCode == 200) {
          editing.value = false;
          getUserData(context);
        }else{
          sendError("Error from server. Try again.");
        }
    } catch (e) {
      print(e);
    }
  }

  void resetValues() {
    lastname.text = userData.lastname;
    emailAddress.text = userData.email;
  }

  void resetEditingState() {
    editing.value = false;
  }

  void sendError(String text) {
    errorMessage.value = text;
    Future.delayed(Duration(seconds: 5), () {
        errorMessage.value = '';
      });
  }

  void logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    context.goNamed("login");
  }
}
