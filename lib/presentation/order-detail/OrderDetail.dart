import 'package:cafe_app/presentation/common/AppBarCoffee.dart';
import 'package:cafe_app/presentation/common/LoadingIndicator.dart';
import 'package:cafe_app/presentation/order-detail/OrderDetailController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({
    super.key,
  });

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  void initState() {
    controller.onLoading();
    super.initState();
  }

  OrderDetailController controller = Get.put(OrderDetailController());
  final scrollContoller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style =
        theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);
    var paddingSubtitles = EdgeInsets.symmetric(vertical: 10.0);

    return Scaffold(
      appBar: AppBarCoffee(title: "Order detail"),
      body: Obx(() => controller.loaded.value ? 
          SingleChildScrollView(
              controller: scrollContoller,
              physics: ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          color: Theme.of(context).primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: ListView.builder(
                        controller: scrollContoller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(
                              "${controller.cartProducts[index].cant} x - ${controller.cartProducts[index].product!.name}",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .fontSize,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              controller.sizes.where((e) => e.id == controller.cartProducts[index].size!).first.size
                            ),
                            trailing: Text(
                                "s/ ${controller.cartProducts[index].totalPrice}",
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .fontSize,
                                    fontWeight: FontWeight.normal)),
                          );
                        },
                        itemCount: controller.cartProducts.length,
                      ),
                    ),
                    Padding(
                      padding: paddingSubtitles,
                      child: Text(
                        "Pick up at",
                        style: style,
                      ),
                    ),
                    controller.stores.isNotEmpty
                        ? DropdownButtonFormField(
                            hint: Text("Select store for pick up..."),
                            value: controller.selectedLocal.value != -1 ? controller.selectedLocal.value : null,
                            items: controller.stores
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                controller.selectedLocal.value = value!;
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                filled: true,
                                fillColor: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(10),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide: BorderSide.none)),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          )
                        : Container(),
                    Padding(
                      padding: paddingSubtitles,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment methods",
                                style: style,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    context.push("/selectPayment");
                                  },
                                  child: Text(
                                    controller.paymentMethod.value == -1 ? 
                                      "Select payment method" : "Change payment method"
                                    ,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                          controller.paymentMethod.value != -1 ? 
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withAlpha(10),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: ListTile(
                                title: Text(
                                  controller.paymentMethod.value == 1 ? "Card" : "Cash on",
                                  style: style,
                                ),
                                trailing: Text(
                                  controller.paymentMethod.value == 1 ? controller.cardInfo.value : "\$",
                                  style: style,
                                )
                              )
                            ),
                          ) : Container()
                        ],
                      ),
                    ),
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          controller.message.string,
                          style: TextStyle(
                            color: controller.messageColor.value
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              )) : LoadingIndicator()
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Obx(() => Text("s/ ${controller.totalPrice.value}", style: const TextStyle(fontWeight: FontWeight.bold),))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor)),
                  onPressed: () {
                    controller.placeOrder(context);
                    //context.goNamed("orderConfirmation");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Place order",
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
