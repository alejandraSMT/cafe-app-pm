import 'package:cafe_app/presentation/common/AppBarCoffee.dart';
import 'package:cafe_app/presentation/common/LoadingIndicator.dart';
import 'package:cafe_app/presentation/my-cards/MyCardsController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MyCards extends StatefulWidget {
  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  MyCardsController controller = Get.put(MyCardsController());
  final scrollContoller = ScrollController();

  @override
  void initState() {
    controller.onLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCoffee(title: "My cards"),
      body: Obx(() => controller.loaded.value
          ? controller.cardsList.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 25, right: 25),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.white)),
                          onPressed: () {
                            context.push("/addCard");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add new card",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .fontSize),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          controller: scrollContoller,
                          child: Padding(
                            padding: EdgeInsets.all(25),
                            child: ListView.builder(
                              shrinkWrap: true,
                              controller: scrollContoller,
                              itemBuilder: (context, index) {
                                var card = controller.cardsList[index];
                                return _cardItem(
                                  cardNumber: card.cardNumber!,
                                  cardHolder: card.holderName!,
                                  cardId: card.id!,
                                  controller: controller,
                                );
                              },
                              itemCount: controller.cardsList.length,
                            ),
                          )),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.payment,
                          color: Colors.grey,
                          size: 60,
                        ),
                        Text(
                          "You don't have saved cards!",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context).primaryColor)),
                              onPressed: () {
                                context.push("/addCard");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add new card",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .fontSize),
                                  )
                                ],
                              )),
                        )
                      ],
                    )
                  ],
                )
          : LoadingIndicator()),
    );
  }
}

class _cardItem extends StatelessWidget {
  const _cardItem({
    required this.cardNumber,
    required this.cardHolder,
    required this.cardId,
    required this.controller,
    super.key,
  });

  final String cardNumber;
  final String cardHolder;
  final int cardId;
  final MyCardsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(25),
        constraints: BoxConstraints(
            maxHeight: 170, minWidth: MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.deleteCard(cardId);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.black38,
                  ),
                )
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardNumber,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      cardHolder,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Text(
                  "VISA",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
