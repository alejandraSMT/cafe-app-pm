import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxString message = "".obs;
  var messageColor = Colors.green.obs;

  void login(BuildContext context){
    String email = emailController.text;
    String pass = passController.text;

    if(email=="123" && pass == "123"){
      context.goNamed("main");
    }else{
      message.value = "User not found";
      messageColor.value = Colors.red;
    }
    Future.delayed(Duration(seconds: 5), () {
      message.value = '';
    });

  }

}