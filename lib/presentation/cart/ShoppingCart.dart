import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/models/CartDetail.dart';
import 'package:cafe_app/models/CartItem.dart';
import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/presentation/common/AppBarCoffee.dart';
import 'package:cafe_app/presentation/common/LoadingIndicator.dart';
import 'package:cafe_app/presentation/home/HomePageController.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:cafe_app/presentation/cart/ShoppingCartController.dart';
import 'package:get/get.dart';

class ShoppingCart extends StatefulWidget {
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final ShoppingCartController controller = Get.put(ShoppingCartController());

  @override
  void initState() {
    controller.onLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCoffee(title: "My cart"),
      body: Obx(() => controller.loaded.value
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Obx(() => controller.cartProducts.isNotEmpty
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return ProductShopping(
                                product: controller.cartProducts.value[index],
                                controller: controller,
                              );
                            },
                            itemCount: controller.cartProducts.length,
                            separatorBuilder: (context, index) => Divider(
                                thickness: 0, color: Colors.transparent),
                            shrinkWrap: true,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.grey,
                                size: 60,
                              ),
                              Text(
                                "Your cart is empty!",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .fontSize),
                              )
                            ],
                          )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Obx(() => Text(
                                  "s/ ${controller.totalPrice}",
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .fontSize,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context).primaryColor)),
                              onPressed: () {
                                controller.completeOrder();
                                context.push("/orderDetail");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Complete order",
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
                  )
                ],
              ),
            )
          : LoadingIndicator()),
    );
  }
}

class ProductShopping extends StatelessWidget {
  const ProductShopping(
      {Key? key, required this.product, required this.controller})
      : super(key: key);

  final CartDetail product;
  final ShoppingCartController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 100),
      child: Card(
        surfaceTintColor: Colors.transparent,
        elevation: null,
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 100),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Image.network(
                  product.product!.image!,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product.product!.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          controller.sizes
                              .firstWhere(
                                  (element) => element.id == product.size!)
                              .size,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .fontSize),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "s/ ${product.totalPrice}",
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .fontSize),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RawMaterialButton(
                              onPressed: () {
                                if (product.cant! == 1) {
                                  print("-------ELIMINAR-----");
                                  print("ID DEL PRODUCTO: ${product.id!}");
                                  controller.deleteFromCart(product.id!);
                                } else {
                                  print("-------DELETE-----");
                                  controller.removeCant(product.id!);
                                }
                              },
                              elevation: 0,
                              fillColor: product.cant! > 1
                                  ? Theme.of(context).primaryColor
                                  : null,
                              shape: CircleBorder(),
                              constraints: BoxConstraints(
                                  maxHeight: 35,
                                  maxWidth: 35,
                                  minHeight: 20,
                                  minWidth: 20),
                              child: product.cant! > 1
                                  ? const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 15,
                                    )
                                  : const Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                      size: 25,
                                    ),
                            ),
                            Text("${product.cant}"),
                            RawMaterialButton(
                              onPressed: () {
                                controller.addCant(product.id!);
                              },
                              elevation: 0,
                              fillColor: Theme.of(context).primaryColor,
                              shape: CircleBorder(),
                              constraints: BoxConstraints(
                                  maxHeight: 35,
                                  maxWidth: 35,
                                  minHeight: 20,
                                  minWidth: 20),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
