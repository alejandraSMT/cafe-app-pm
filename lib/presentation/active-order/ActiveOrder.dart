import 'package:cafe_app/presentation/active-order/ActiveOrderController.dart';
import 'package:cafe_app/presentation/common/AppBarCoffee.dart';
import 'package:cafe_app/presentation/common/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ActiveOrder extends StatefulWidget {
  ActiveOrder({super.key, required this.orderId});

  final String orderId;
  @override
  State<ActiveOrder> createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  ActiveOrderController controller = Get.put(ActiveOrderController());

  @override
  void initState() {
    controller.getActiveOrderInfo(widget.orderId);
    super.initState();
  }

  final scrollContoller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style =
        theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);
    var paddingSubtitles = const EdgeInsets.symmetric(vertical: 10.0);

    return Scaffold(
        appBar: AppBarCoffee(title: "Current order"),
        body: Obx(() => controller.loaded.value
            ? Expanded(
                child: SingleChildScrollView(
                  controller: scrollContoller,
                  physics: const ScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: paddingSubtitles,
                          child: Text(
                            "Pick up at",
                            style: style,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            "${controller.orderDetail.value.store!.address}",
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width - 10,
                              maxHeight: MediaQuery.of(context).size.height / 5
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25))
                            ),
                            child: Image.network(
                              controller.orderDetail.value.store!.image!,
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                        Padding(
                          padding: paddingSubtitles,
                          child: Text(
                            "Products",
                            style: style,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).primaryColor.withAlpha(10),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: ListView.builder(
                            controller: scrollContoller,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                titleAlignment: ListTileTitleAlignment.center,
                                title: Text(
                                  "${controller.orderDetail.value.details![index].cant} x - ${controller.orderDetail.value.details![index].product!.name}",
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .fontSize,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Text(
                                    "s/ ${controller.orderDetail.value.details![index].totalPrice}",
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .fontSize,
                                        fontWeight: FontWeight.normal)),
                              );
                            },
                            itemCount:
                                controller.orderDetail.value.details!.length,
                          ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize
                                      ),
                                    ),
                                    Text(
                                      "s/ ${controller.orderDetail.value.totalPrice}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ),
                        Padding(
                          padding: paddingSubtitles,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Payment method",
                                    style: style,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withAlpha(10),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: ListTile(
                                        title: Text(
                                          //controller.paymentMethod.value == 1 ? "Card" : "Cash on",
                                          "Cash",
                                          style: style,
                                        ),
                                        trailing: Text(
                                          "UWU",
                                          //controller.paymentMethod.value == 1 ? controller.cardInfo.value : "\$",
                                          style: style,
                                        ))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : LoadingIndicator()),
        bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Confirm when your order has been picked up",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor)),
                  onPressed: () {
                    controller.changeOrderStatus(widget.orderId, context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Order recieved",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .fontSize),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
      );
  }
}
