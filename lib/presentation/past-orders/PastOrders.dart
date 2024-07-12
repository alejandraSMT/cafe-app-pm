import 'package:cafe_app/presentation/common/LoadingIndicator.dart';
import 'package:cafe_app/presentation/past-orders/PastOrdersController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastOrders extends StatefulWidget {
  PastOrders({Key? key}) : super(key: key);

  @override
  State<PastOrders> createState() => _PastOrdersState();
}

class _PastOrdersState extends State<PastOrders> {
  final PastOrdersController controller = Get.put(PastOrdersController());

  final scrollContoller = ScrollController();

  @override
  void initState() {
    controller.onLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Obx(() => controller.loaded.value
          ? Expanded(
              child: SingleChildScrollView(
              controller: scrollContoller,
              physics: ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ListView.separated(
                        controller: scrollContoller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var order = controller.pastOrders[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '#${order.orderId} - ',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${order.date!.substring(0, 10)}',
                                      style: TextStyle(fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 0),
                                Text(
                                  '${order.store!.name}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('S/.${order.totalPrice}')
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.grey,
                          );
                        },
                        itemCount: controller.pastOrders.length,
                      ),
                    ),
                  ],
                ),
              ),
            ))
          : LoadingIndicator()),
    );
    /*return Obx(() {
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
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black), // Borde negro
            borderRadius: BorderRadius.circular(20), // Bordes redondeados
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: ListView.separated(
                  controller: scrollContoller,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var order = controller.pastOrders[index];
                    return Row(
                          children: [
                            Text(
                              '#${order.orderId} - ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${order.date}',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                            SizedBox(height: 0),
                            Text(
                              '${order.storeName}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('S/.${order.totalPrice}')
                          ],
                        );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey,
                    );
                  },
                  itemCount: controller.pastOrders.length,
                ),
              ),
            ),
            /*child: Column(
        children: controller.pastOrders.map((order) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '#${order.orderId} - ',
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
                '${order.storeName}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('S/.${order.totalPrice}'),
              SizedBox(height: 2), // Espacio entre pedidos
              Divider( //para la linea
                color: Colors.black, // Color de la línea
                thickness: 0, // Grosor de la línea
                height: 10, // Altura de la línea en caso de estar en un Column
              ),
            ],
          );
        }).toList(),
      ),*/
          ),
        ),
      );
    });*/
  }
}
