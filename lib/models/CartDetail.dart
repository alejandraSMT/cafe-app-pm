import 'package:cafe_app/models/Product.dart';

class CartDetail{
  int? id;
  int? size;
  int? cant;
  double? totalPrice;
  Product? product;

  CartDetail({
    this.id,
    this.size,
    this.cant,
    this.totalPrice,
    this.product
  });

  CartDetail.fromJson(Map<dynamic, dynamic> json){
    id = json['id'];
    size = json['Tamaño'];
    cant = json['Cantidad'];
    totalPrice = double.parse(json['Precio'].toString());
    product = Product.fromJson(json['producto']);
  }


}