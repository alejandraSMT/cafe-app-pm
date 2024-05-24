import 'package:cafe_app/presentation/past-orders/PastOrdersController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastOrders extends StatelessWidget {
  PastOrders({Key? key}) : super(key: key);

  final PastOrdersController controller = Get.put(PastOrdersController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.pastOrders.isEmpty) {
        return Center(child: Text("No past orders found."));
      }

      return Scaffold(
  appBar: AppBar(
    title: Text(
      "My Orders",
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  body: Container(
    padding: EdgeInsets.all(20),
    margin: EdgeInsets.all(60),
    decoration: BoxDecoration(
    border: Border.all(color: Colors.black), // Borde negro
    borderRadius: BorderRadius.circular(20), // Bordes redondeados
    ),
    
    child: SingleChildScrollView(
      
      child: Column(
        children: controller.pastOrders.map((order) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '#${order.number} - ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${order.date}',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(height: 0),
              Text(
                '${order.local}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('S/.${order.price} - ${order.quantity} products'),
              SizedBox(height: 2), // Espacio entre pedidos
              Divider( //para la linea
                color: Colors.black, // Color de la línea
                thickness: 0, // Grosor de la línea
                height: 10, // Altura de la línea en caso de estar en un Column
              ),
            ],
          );
        }).toList(),
      ),
    ),
  ),
);





    });
  }
}
