import 'dart:ffi';

import 'package:cafe_app/models/Product.dart';

class CartItem{
  Product product;
  int quantity;
  double totalPrice;

  CartItem({
    required this.product,
    required this.quantity,
    required this.totalPrice
  });

}