import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/presentation/home/HomePageController.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ShoppingCartController extends GetxController {

  var cartProducts = [].obs;

  void addToCart(Product product) {
    cartProducts.add(product);
  }

  void removeFromCart(Product product) {
    cartProducts.remove(product);
  }

  double calculateTotal() {
    double total = 0;
    for (var product in cartProducts) {
      total += double.parse(product.price!);
    }
    return total;
  }
  void completeOrder() {
  
  }
}
