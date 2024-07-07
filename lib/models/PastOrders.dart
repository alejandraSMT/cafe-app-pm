import 'package:cafe_app/models/Store.dart';

class PastOrders{

  int? orderId;
  String? date;
  String? storeName;
  double? totalPrice;
  int? status;

  PastOrders({
    this.orderId,
    this.date,
    this.storeName,
    this.totalPrice,
    this.status
  });

  PastOrders.fromJson(Map<dynamic,dynamic> json){
    orderId = json['id'];
    date = json['FechaHora'];
    storeName = Store.fromJson(json['local']).name;
    totalPrice = double.parse(json['Total'].toString());
    status = json['Estatus'];
  }

}