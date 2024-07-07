import 'dart:convert';

import 'package:cafe_app/models/CartDetail.dart';
import 'package:cafe_app/models/CartItem.dart';
import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/presentation/home/HomePageController.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;
import '../../models/SizeCup.dart';

class ShoppingCartController extends GetxController {
  var cartProducts = [].obs;
  RxInt cartId = 0.obs;
  RxInt totalItems = 0.obs;
  RxString totalPrice = "0".obs;
  RxBool loaded = false.obs;
  List<SizeCup> sizes = [];

  Future<void> onLoading() async {
    cartProducts.clear();
    await setSizes();
    await getCartItems();
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

  Future<void> getCartItems() async {
    try {
      loaded.value = false;

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      final response = await http.get(
          Uri.parse(
              "${globals.url_base}api/carritoDetalle/obtenerCarritoConTodosLosDatos"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });

      if (response.statusCode != 200) {
        print("Error fetching cart data");
        loaded.value = true;
        return;
      }

      totalPrice.value = json.decode(response.body)['Total'].toString();
      cartId.value = json.decode(response.body)['carritoId'];

      final body = json.decode(response.body)['carritosDetalles'].toList();
      for (var e in body as List) {
        cartProducts.add(CartDetail.fromJson(e));
      }

      loaded.value = true;
    } catch (e) {
      print("Error getting cart data: $e");
      loaded.value = true;
    }
  }

  Future<void> addCant(int prodId) async {
    try {
      final response = await http.patch(Uri.parse(
          "${globals.url_base}api/carritoDetalle/modificarDetalleCarritoMas/?cantidad=1&carritoDetalleId=$prodId"));

      if (response.statusCode != 200) {
        print("Error updating unit");
        return;
      }

      onLoading();
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeCant(int prodId) async {
    try {
      try {
        final response = await http.patch(Uri.parse(
            "${globals.url_base}api/carritoDetalle/modificarDetalleCarritoMenos/?cantidad=1&carritoDetalleId=$prodId"));

        if (response.statusCode != 200) {
          print("Error updating unit");
          return;
        }

        onLoading();
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFromCart(int prodId) async{
    try{
      final response = await http.delete(Uri.parse(
            "${globals.url_base}api/carritoDetalle/eliminarDetalleCarrito?carritoDetalleId=$prodId"));

        if (response.statusCode != 204) {
          print("Error deleting");
          return;
        }

        onLoading();
    }catch(e){
      print("Error deleting from cart: $e");
    }
  }

  void completeOrder() {}
}
