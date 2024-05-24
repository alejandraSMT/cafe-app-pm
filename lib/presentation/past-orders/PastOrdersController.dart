import 'package:get/get.dart';
import 'package:cafe_app/models/Order.dart';

class PastOrdersController extends GetxController {
  var pastOrders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPastOrders();
  }

  void loadPastOrders() {
    final data = [
      {
        "number": "1",
        "date": "21/05/24",
        "payMethod": "Credit Card",
        "price": "100",
        "quantity": "4",
        "local": "Surco",
      },
      {
        "number": "2",
        "date": "22/05/24",
        "payMethod": "Cash",
        "price": "50",
        "quantity": "2",
        "local": "San Miguel",
      },
      {
        "number": "3",
        "date": "20/05/24",
        "payMethod": "Credit Card",
        "price": "150",
        "quantity": "5",
        "local": "Salamanca",
      },
      {
        "number": "4",
        "date": "21/05/24",
        "payMethod": "Cash",
        "price": "20",
        "quantity": "2",
        "local": "Surco",
      },
    ];
    pastOrders.addAll(data.map<Order>((json) => Order.fromJson(json)).toList());
  }
}
