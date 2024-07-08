import 'package:cafe_app/models/CartDetail.dart';
import 'package:cafe_app/models/Store.dart';

class OrderDetail{

  int? orderId;
  String? date;
  Store? store;
  double? totalPrice;
  int? status;
  List<CartDetail>? details;

  OrderDetail({
    this.orderId,
    this.date,
    this.store,
    this.totalPrice,
    this.status,
    this.details
  });

  OrderDetail.fromJson(Map<dynamic,dynamic> json){
    orderId = json['id'];
    date = json['FechaHora'];
    store = Store.fromJson(json['local']);
    totalPrice = double.parse(json['Total'].toString());
    status = json['Estatus'];
    details = <CartDetail>[];
      (json['detallesorden'] as List).forEach((element) {
        details!.add(CartDetail.fromJson(element));
      });
  }

}