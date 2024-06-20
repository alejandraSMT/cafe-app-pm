import 'dart:convert';

import 'package:cafe_app/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;
import '../../utils/functions.dart';

class SignUpController extends GetxController {
  TextEditingController nameControllerSign = TextEditingController();
  TextEditingController lastnameControllerSign = TextEditingController();
  TextEditingController emailControllerSign = TextEditingController();
  TextEditingController passwordControllerSign = TextEditingController();
  TextEditingController confirmPasswordControllerSign = TextEditingController();

  RxString message = "".obs;
  RxBool showMessageBox = false.obs;
  var messageColor = Colors.green.obs;

  Future<void> registerUserApi(BuildContext context) async {
    try {
      String name = nameControllerSign.text;
      String lastname = lastnameControllerSign.text;
      String email = emailControllerSign.text;
      String password = passwordControllerSign.text;
      String confirmedPassword = confirmPasswordControllerSign.text;

      if (isAllSpaces(name)) {
        sendError("Name not provided.");
        return;
      }

      if (isAllSpaces(lastname)) {
        sendError("Lastname not provided");
        return;
      }

      if (isAllSpaces(email)) {
        sendError("Email not provided.");
        return;
      }

      var validEstructure = RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
      if (!validEstructure.hasMatch(email)) {
        sendError("Email not valid.");
        return;
      }

      if (isAllSpaces(password) || isAllSpaces(confirmedPassword)) {
        sendError("Password not provided.");
        return;
      }

      if (password != confirmedPassword) {
        sendError("Passwords do not match.");
        return;
      }

      
      Map body = {
            'nombre': name,
            'apellido': lastname,
            'emailAddress': email,
            'contraseña': password 
      };
      print(body);
      final response = await http.post(
          Uri.parse('${globals.url_base}api/usuario/registrarUsuario'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        context.goNamed("login");
      } else {
        sendError(response.body.toString());
        throw Exception('Failed to create user: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  void sendError(String text) {
    message.value = text;
    messageColor.value = Colors.red;
    showMessageBox.value = true;
  }

  Widget returnSpace() {
    if (showMessageBox.value) {
      return SizedBox(height: 15);
    } else {
      return SizedBox.shrink();
    }
  }
}
