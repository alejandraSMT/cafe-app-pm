import 'package:cafe_app/presentation/common/AppBarCoffee.dart';
import 'package:cafe_app/presentation/common/LoadingIndicator.dart';
import 'package:cafe_app/presentation/my-cards/MyCardsController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCards extends StatefulWidget {
  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  MyCardsController controller = Get.put(MyCardsController());
  final scrollContoller = ScrollController();

  @override
  void initState() {
    controller.getCardsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCoffee(title: "My cards"),
      body: SingleChildScrollView(
        controller: scrollContoller,
          child: Obx(() => controller.loaded.value
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: scrollContoller,
                        itemBuilder: (context, index) {
                          return  _cardItem(
                            cardNumber: controller.cardsList[index].cardNumber,
                            cardHolder: controller.cardsList[index].holderName,
                          );
                        },
                        itemCount: controller.cardsList.length,
                      ),
                    )
                  ],
                )
              : LoadingIndicator())),
    );
  }
}

class _cardItem extends StatelessWidget {
  const _cardItem({
    required this.cardNumber,
    required this.cardHolder,
    super.key,
  });

  final String cardNumber;
  final String cardHolder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(25),
        constraints: BoxConstraints(
            maxHeight: 170,
            minWidth: MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius:
                BorderRadius.all(Radius.circular(25))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardNumber.substring(10,15),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
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
