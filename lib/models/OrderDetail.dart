import 'package:cafe_app/models/CardItem.dart';
import 'package:cafe_app/models/CartDetail.dart';
import 'package:cafe_app/models/Store.dart';

class OrderDetail{

  int? orderId;
  String? date;
  Store? store;
  double? totalPrice;
  int? status;
  List<CartDetail>? details;
  int? paymentMethod;
  CardItem? cardInfo;

  OrderDetail({
    this.orderId,
    this.date,
    this.store,
    this.totalPrice,
    this.status,
    this.details,
    this.paymentMethod,
    this.cardInfo
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
    if(json['MedioDePago'] != null){
      paymentMethod = json['MedioDePago'];
    }
    if(json['tarjeta'] != null){
      cardInfo = CardItem.fromJson(json['tarjeta']);
    }
  }

}