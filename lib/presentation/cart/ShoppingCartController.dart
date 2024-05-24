import 'package:cafe_app/models/CartItem.dart';
import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/presentation/home/HomePageController.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ShoppingCartController extends GetxController {
  var cartProducts = [].obs;
  RxDouble total = 0.0.obs;
  RxInt totalItems = 0.obs;

  void addToCart(Product product, int cant, double total) {
    var cartItem = CartItem(product: product, quantity: cant, totalPrice: total);
    cartProducts.add(cartItem);
    totalItems.value += cant;
  }

  void removeFromCart(Product product) {
    cartProducts.remove(product);
  }

  void calculateTotal() {
    cartProducts.value.forEach((element) { 
      total.value += element.totalPrice;
    });
    print(total.value);
  }

  void completeOrder() {}
}
