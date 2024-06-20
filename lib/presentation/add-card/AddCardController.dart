import 'dart:convert';

import 'package:cafe_app/presentation/select-payment/SelectPaymentController.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:go_router/go_router.dart';
import '../../utils/functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;

class AddCardController extends GetxController {
  RxString cardNumber = "".obs;
  RxString expiryDate = "".obs;
  RxString cardHolderName = "".obs;
  RxString cvvCode = "".obs;
  RxString message = "".obs;

  RxBool loaded = false.obs;

  SelectPaymentController selectPaymentController = Get.put(SelectPaymentController());

  Future<void> cardInfo(BuildContext context) async {
    try {
      loaded.value = false;
      if (isAllSpaces(cardNumber.value) &&
          isAllSpaces(expiryDate.value) &&
          isAllSpaces(cardHolderName.value) &&
          isAllSpaces(cvvCode.value)) {
        sendError("All fields are required.");
        return;
      }

      if (isAllSpaces(cardNumber.value)) {
        sendError("Card number not provided.");
        return;
      }

      if (isAllSpaces(expiryDate.value)) {
        sendError("Expiry date not provided.");
        return;
      }

      if (isAllSpaces(cardHolderName.value)) {
        sendError("Card holder's name not provided.");
        return;
      }

      if (isAllSpaces(cvvCode.value)) {
        sendError("CVV code not provided.");
        return;
      }

      String newCardNumber = cardNumber.value.replaceAll(" ", '');
      String newMonth = expiryDate.value.split("/").first;
      String newYear = expiryDate.value.split("/").last;

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      Map body = {
        "NumeroTarjeta": newCardNumber,
        "FechaVMes": newMonth,
        "FechaVAño": newYear,
        "Codigo": cvvCode.value,
        "NombreTarjeta": cardHolderName.value
      };

      final response = await http.post(
          Uri.parse('${globals.url_base}api/tarjeta/crearTarjeta'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(body));

      selectPaymentController.getUsersCards();

      loaded.value = true;
      
      if(response.statusCode == 200){
        context.pop();
      }else{
        sendError(response.body.toString());
      }

    } catch (e) {
      print(e);
    }
  }

  void sendError(String text) {
    message.value = text;
    Future.delayed(Duration(seconds: 5), () {
      message.value = '';
    });
  }

  void resetValues(){
    cardNumber.value = "";
    expiryDate.value = "";
    cardHolderName.value = "";
    cvvCode.value = "";
    message.value = "";
  }

}
