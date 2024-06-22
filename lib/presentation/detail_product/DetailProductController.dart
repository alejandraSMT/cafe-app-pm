import 'dart:convert';

import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/presentation/home/HomePageController.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;


class DetailProductController extends GetxController{
  final HomePageController controller = Get.put(HomePageController());

  RxBool loaded = false.obs;

  Rx<Product> productSelected = Product().obs;
  RxDouble totalPrice = 0.0.obs;
  RxInt totalUnits = 1.obs;
  RxInt sizeSelected = 0.obs;

  Future<void> getProductDetail(String productId) async {
    try{
      loaded.value = false;

      final response = await http.get(
        Uri.parse("${globals.url_base}api/productos/traerproductoConIngredientes?id=$productId")
      );

      if(response.statusCode != 200){
        return;
      }

      var body = Product.fromJson(json.decode(response.body)['producto']);
      productSelected.value = body;


      totalPrice.value = productSelected.value.price!;
      totalUnits.value = 1;
      sizeSelected.value = 0;

      loaded.value = true;
    }catch(e){
      print(e);
    }
  }

  void addTotalAmount(){
    totalUnits.value += 1;
    calculateTotal();
  }

  void reduceTotalAmount(){
    if(totalUnits.value > 1){
      totalUnits.value -= 1;
      calculateTotal();
    }
  }

  void calculateTotal(){
    if(totalUnits.value > 0){
      totalPrice.value = (productSelected.value.price!*totalUnits.value);
    }
  }

  void setSize(int size){
    sizeSelected.value = size;
  }
  
}