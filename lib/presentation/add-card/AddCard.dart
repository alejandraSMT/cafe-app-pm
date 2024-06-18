import 'package:cafe_app/presentation/order-detail/OrderDetailController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

class AddCard extends StatefulWidget {
  const AddCard({
    super.key,
  });

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final scrollContoller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var labelStyle =
        theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
          ),
          title: Text(
            "Add Card",
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
                      Text("Name on card", style: labelStyle),
                      SizedBox(height: 5),
                      const TextField(
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              hintText: 'Name')),
                      SizedBox(height: 10),
                      Text("Number on card", style: labelStyle),
                      SizedBox(height: 5),
                      const TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              hintText: 'Number')),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 150),
                            child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    hintText: 'Number')),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: 150),
                            child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    hintText: 'Number')),
                          )
                        ],
                      )
                    ],
                  ),
                ))));
  }
}
