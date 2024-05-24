import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({
    super.key,
  });

  @override
  State<OrderConfirmation> createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  //OrderConfirmationController controller = Get.put(OrderConfirmationController());

   @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200, 
                child: Image.asset(
                  'assets/images/order-confirmation.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              "Your order has been placed successfully",
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24.0, // Ajusta el tamaño de fuente según tus necesidades
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
              ),
              onPressed: () {
                context.goNamed("main");
              },
              child: Text(
                "Go to Home",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: theme.textTheme.bodyLarge!.fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}