import 'package:cafe_app/presentation/common/AppBarCoffee.dart';
import 'package:cafe_app/presentation/order-detail/OrderDetailController.dart';
import 'package:cafe_app/presentation/select-payment/SelectPaymentController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

class SelectPayment extends StatefulWidget {
  const SelectPayment({
    super.key,
  });

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  final scrollContoller = ScrollController();

  SelectPaymentController controller = Get.put(SelectPaymentController());

  @override
  void initState() {
    controller.getUsersCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style =
        theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
        appBar: AppBarCoffee(title: "Select payment"),
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
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(10),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: ListTile(
                              leading: Image.asset("assets/images/card.png"),
                              title: Text(
                                "Card",
                                style: style,
                              ),
                              trailing: GestureDetector(
                                  onTap: () {
                                    context.push("/addCard");
                                  },
                                  child: Icon(
                                    Icons.add_card,
                                    semanticLabel: "Add card",
                                  )),
                            ),
                          ),
                          controller.cardsList.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: ListView.separated(
                                      controller: scrollContoller,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var card = controller.cardsList[index];
                                        return Obx(() => ListTile(
                                              onTap: () {
                                                controller.selectCard(card.id);
                                              },
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              subtitle: Text(
                                                card.holderName,
                                                style: TextStyle(
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge!
                                                        .fontSize,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              title: Text(
                                                card.cardNumber
                                                    .substring(10, 15),
                                                style: TextStyle(
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge!
                                                        .fontSize,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              trailing: card.id ==
                                                      controller
                                                          .cardSelected.value
                                                  ? Icon(Icons.check)
                                                  : null,
                                            ));
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          color: Colors.grey,
                                        );
                                      },
                                      itemCount: controller.cardsList.length,
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(height: 10),
                          Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withAlpha(10),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Obx(() => ListTile(
                                    onTap: () {
                                      controller.cashOnSelected();
                                    },
                                    leading: Image.asset(
                                        "assets/images/cash-on.png"),
                                    title: Text("Cash on", style: style),
                                    trailing: controller.paymentMethod.value == 0
                                        ? Icon(Icons.check)
                                        : null,
                                  )))
                        ],
                      ),
                    )))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              )));
  }
}
