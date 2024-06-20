import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;

class ChangePasswordController extends GetxController {
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordVerify = TextEditingController();
  RxString message = "".obs;

  Future<void> changePassword(BuildContext context) async {
    try {
      if (isAllSpaces(newPassword.text) ||
          isAllSpaces(newPasswordVerify.text)) {
        sendError("Password not provided.");
        return;
      }

      if (newPassword.text != newPasswordVerify.text) {
        sendError("Passwords do not match.");
        return;
      }

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      final response = await http.post(
          Uri.parse(
              "${globals.url_base}api/usuario/actualizarcontrasena?contraseña=${newPassword.value}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      print("RESPUESTA: ${response.statusCode}");
      if (response.statusCode == 200) {
        context.pop();
      } else {
        message.value = response.body.toString();
      }
    } catch (e) {
      print(e);
    }
  }

  void resetValues() {
    newPassword.text = "";
    newPasswordVerify.text = "";
    message.value = '';
  }

  void sendError(String text) {
    message.value = text;
    Future.delayed(Duration(seconds: 5), () {
        message.value = '';
      });
  }

}
