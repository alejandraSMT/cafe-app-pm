import 'dart:convert';

import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/models/SizeCup.dart';
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
  List<SizeCup> sizes = [];

  Future<void> onLoading(String productId) async{
    sizes.clear();
    await setSizes();
    await getProductDetail(productId);
  }

  Future<void> setSizes() async{
    const body = [
      {
        "id": 1,
        "size": "Small"
      },
      {
        "id": 2,
        "size": "Medium"
      },
      {
        "id": 3,
        "size": "Large"
      }
    ];
    sizes.addAll(body.map<SizeCup>(SizeCup.fromJson).toList());
  }

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
  
  Future<void> addProductToCart(int productId, int cant, int size) async{
    try{
      Map body = {
        "userId": "6",
        "productoId": productId.toString(),
        "cantidad": cant.toString(),
        "tamaño": size.toString()
      };

      print("BODY: $body");
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      final response = await http.post(
        Uri.parse("${globals.url_base}api/carritoDetalle/agregarACarrito"),
        headers: {
          'Authorization': 'Bearer $token'},
        body: body
      );

      if(response.statusCode != 201){
        print("error!: ${response.body}");
        return;
      }

      print(response.body);

    }catch(e){
      print("Error adding to cart: $e");
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