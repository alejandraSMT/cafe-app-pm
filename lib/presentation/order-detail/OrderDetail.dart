import 'package:cafe_app/presentation/common/AppBarCoffee.dart';
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
      body: Expanded(
          child: SingleChildScrollView(
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
                            titleAlignment: ListTileTitleAlignment.top,
                            title: Text(
                              "${controller.productsCart[index].cant!}x - ${controller.productsCart[index].name!}",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .fontSize,
                                  fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                                "s/ ${controller.productsCart[index].price!}",
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .fontSize,
                                    fontWeight: FontWeight.normal)),
                          );
                        },
                        itemCount: controller.productsCart.length,
                      ),
                    ),
                    Padding(
                      padding: paddingSubtitles,
                      child: Text(
                        "Pick up at",
                        style: style,
                      ),
                    ),
                    DropdownButtonFormField(
                      hint: Text("Select store for pick up..."),
                      items: controller.stores
                          .map((e) => DropdownMenuItem(
                              value: e.values.first,
                              child: Text(e.values.last)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          controller.selectedLocal.value = value!;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor:
                              Theme.of(context).primaryColor.withAlpha(10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide.none)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    Padding(
                      padding: paddingSubtitles,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment methods",
                            style: style,
                          ),
                           GestureDetector(
                            onTap: (){
                              context.push("/selectPayment");
                            },
                            child : Text(
                            "Select payment method",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ))),
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
                Text("s/ 25.90")
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor)),
                  onPressed: () {
                    context.goNamed("orderConfirmation");
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
