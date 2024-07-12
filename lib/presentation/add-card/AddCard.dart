import 'package:cafe_app/presentation/add-card/AddCardController.dart';
import 'package:cafe_app/presentation/common/AppBarCoffee.dart';
import 'package:cafe_app/presentation/order-detail/OrderDetailController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:http/http.dart';

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
  void initState() {
    addCardController.resetValues();
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddCardController addCardController = Get.put(AddCardController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var labelStyle =
        theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);

    void onCreditCardModelChange(CreditCardModel creditCardModel) {
      addCardController.cardNumber.value = creditCardModel.cardNumber;
      addCardController.expiryDate.value = creditCardModel.expiryDate;
      addCardController.cardHolderName.value = creditCardModel.cardHolderName;
      addCardController.cvvCode.value = creditCardModel.cvvCode;
    }

    return Scaffold(
        appBar: AppBarCoffee(title: "Add card"),
        body: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => 
                CreditCardWidget(
                  cardBgColor: Colors.blue,
                  cardNumber: addCardController.cardNumber.value,
                  expiryDate: addCardController.expiryDate.value,
                  cardHolderName: addCardController.cardHolderName.value,
                  cvvCode: addCardController.cvvCode.value,
                  showBackView: false, //true when you want to show cvv(back) view
                  isHolderNameVisible: true,
                  onCreditCardWidgetChange: (CreditCardBrand
                      brand) {}, // Callback for anytime credit card brand is changed
                )
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  CreditCardForm(
                    obscureCvv: true,
                    cardNumber: addCardController.cardNumber.value,
                    expiryDate: addCardController.expiryDate.value,
                    cardHolderName: addCardController.cardHolderName.value,
                    cvvCode: addCardController.cvvCode.value,
                    onCreditCardModelChange: onCreditCardModelChange,
                    formKey: formKey,
                    inputConfiguration: InputConfiguration(
                      cardNumberDecoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                        labelText: 'Card Holder',
                      ),
                    ),
                  ),
                  Obx(() => addCardController.message.value != ''
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                addCardController.message.value,
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          ],
                        )
                      : Container()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            addCardController.cardInfo(context);
                            //context.goNamed('main');
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(350, 40),
                              backgroundColor: Theme.of(context).primaryColor,
                              textStyle: TextStyle(color: Colors.white)),
                          child: Text(
                            "Add card",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontSize),
                          )),
                    ),
                  )
                ],
              )))
            ],
          ),
        ));
  }
}
