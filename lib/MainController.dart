import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController{

  void getSPValue(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(sp.getBool("isLogged") != null ){
      context.goNamed("main");
    }
  }


}