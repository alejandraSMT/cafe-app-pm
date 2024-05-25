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
  RxBool showMessageBox = false.obs;
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
    
    var validEstructure = RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (!validEstructure.hasMatch(email)) 
    {
      sendError("Email not valid.");
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
    showMessageBox.value = true;
  }

  bool isAllSpaces(String input)
  {
    return input.replaceAll(' ', '') == '';
  }

  Widget returnSpace(){
    if(showMessageBox.value)
    {
      return SizedBox(height: 15);
    }
    else
    {
      return SizedBox.shrink();
    }
  }
}
