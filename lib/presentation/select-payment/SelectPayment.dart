import 'package:cafe_app/presentation/order-detail/OrderDetailController.dart';
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

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style =
        theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              context.goNamed("orderDetail");
            },
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
          ),
          title: Text(
            "Select payment",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
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
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withAlpha(10),
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
                                context.goNamed("addCard");
                              },
                              child: Icon(
                                Icons.add_card,
                                semanticLabel: "Add card",
                              )),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withAlpha(10),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: ListTile(
                          leading: Image.asset("assets/images/cash-on.png"),
                          title: Text(
                            "Cash on",
                            style: style,
                          ),
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
