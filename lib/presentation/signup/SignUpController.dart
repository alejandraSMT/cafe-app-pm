import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SignUpController extends GetxController
{
  TextEditingController nameControllerSign = TextEditingController();
  TextEditingController emailControllerSign = TextEditingController();
  TextEditingController passwordControllerSign = TextEditingController();
  TextEditingController confirmPasswordControllerSign = TextEditingController();

  RxString message = "".obs;
  var messageColor = Colors.green.obs;

  void signup (BuildContext context)
  {
    String name = nameControllerSign.text;
    String email = emailControllerSign.text;
    String password = passwordControllerSign.text;
    String confirmedPassword = confirmPasswordControllerSign.text;

    if (isAllSpaces(name)) 
    {
      sendError("Name not provided.");
      return;
    }

    if (isAllSpaces(email)) 
    {
      sendError("Email not provided.");
      return;
    }

    if (isAllSpaces(password) || isAllSpaces(confirmedPassword)) 
    {
      sendError("Password not provided.");
      return;
    }

    if (password != confirmedPassword) 
    {
      sendError("Passwords do not match.");
      return;
    }

    print('Name: $name');
    print('Email: $email');
    print('Password 1: $password');
    print('Password 2: $confirmedPassword');

    context.goNamed("login");
  }

  void sendError(String text){
    message.value = text;
    messageColor.value = Colors.red;
  }

  bool isAllSpaces(String input)
  {
    return input.replaceAll(' ', '') == '';
  }
}