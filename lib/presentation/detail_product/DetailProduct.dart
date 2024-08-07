import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
// ignore: unnecessary_import
import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/models/SizeCup.dart';
import 'package:cafe_app/presentation/common/LoadingIndicator.dart';
import 'package:cafe_app/presentation/detail_product/DetailProductController.dart';
import 'package:cafe_app/presentation/home/HomePageController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:cafe_app/presentation/cart/ShoppingCartController.dart';

class DetailProduct extends StatefulWidget {
  DetailProduct({super.key, required this.index});

  final String index;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final DetailProductController detailController =
      Get.put(DetailProductController());
  final ShoppingCartController cartController =
      Get.put(ShoppingCartController());
  final scrollContoller = ScrollController();

  @override
  void initState() {
    detailController.onLoading(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => detailController.loaded.value
        ? Scaffold(
            bottomSheet: _buttons(
                controller: detailController,
                index: widget.index,
                product: detailController.productSelected.value,
                cartController: cartController),
            body: Stack(children: [
              Container(
                child: Image.network(detailController.productSelected.value.image!),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 270.0),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 42),
                    controller: scrollContoller,
                    physics: ScrollPhysics(),
                    child: Container(
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50))),
                            margin: EdgeInsets.all(0),
                            color: Colors.white,
                            shadowColor: Colors.transparent,
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detailController.productSelected.value.name!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .fontSize),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(detailController.productSelected.value.description!),
                                  ),
                                  detailController.sizes.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Container(
                                            constraints:
                                                BoxConstraints(maxHeight: 50),
                                            child: ListView.separated(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (context, indexSize) {
                                                  return Obx(() => _cardSize(
                                                        sizeItem: detailController.sizes[indexSize],
                                                        indexSize: indexSize,
                                                        onSelectedChange: () {
                                                          setState(() {
                                                            detailController
                                                                .setSize(
                                                                    indexSize);
                                                          });
                                                        },
                                                        sizedSelected:
                                                            detailController
                                                                .sizeSelected
                                                                .value,
                                                      ));
                                                },
                                                separatorBuilder:
                                                    (context, indexSize) {
                                                  return Divider();
                                                },
                                                itemCount:
                                                    detailController.sizes.length),
                                          ),
                                        )
                                      : Container(),
                                      detailController.productSelected.value.ingredients != null
                                      ? Obx(() => 
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Text(
                                                "Ingredients: ",
                                                style: TextStyle(
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .fontSize,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            ListView.separated(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, pos) {
                                                  return ListTile(
                                                    visualDensity:
                                                        VisualDensity(
                                                            vertical: -3),
                                                    leading: Icon(
                                                        Icons.coffee_rounded),
                                                    title: Text(detailController.productSelected.value
                                                        .ingredients![pos]
                                                        .ingredientName),
                                                    contentPadding:
                                                        EdgeInsets.all(2),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, pos) {
                                                  return Divider(
                                                    color: Colors.grey,
                                                    thickness: 0.2,
                                                  );
                                                },
                                                itemCount:
                                                    detailController.productSelected.value.ingredients!.length)
                                          ],
                                        )
                                      )
                                      : Container()
                                ],
                              ),
                            ))),
                  )),
              _onBackButton(),
            ]),
          )
        : LoadingIndicator());
  }
}

class _cardSize extends StatefulWidget {
  const _cardSize(
      {super.key,
      required this.sizeItem,
      required this.indexSize,
      required this.onSelectedChange,
      required this.sizedSelected});

  final SizeCup sizeItem;
  final int indexSize;
  final VoidCallback onSelectedChange;
  final int sizedSelected;

  @override
  State<_cardSize> createState() => _cardSizeState();
}

class _cardSizeState extends State<_cardSize> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onSelectedChange();
        });
      },
      child: Card(
        color: widget.sizedSelected == widget.indexSize
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        elevation: null,
        shadowColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            widget.sizeItem.size,
            style: TextStyle(
                color: widget.sizedSelected == widget.indexSize
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}

class _buttons extends StatelessWidget {
  const _buttons(
      {super.key,
      required this.controller,
      required this.index,
      required this.cartController,
      required this.product});

  final DetailProductController controller;
  final ShoppingCartController cartController;
  final String index;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 170),
              child: Card(
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 9.0, horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            controller.reduceTotalAmount();
                          },
                          focusColor: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Icon(Icons.remove)),
                      Obx(() => Text(
                            "${controller.totalUnits.value}",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontSize),
                          )),
                      InkWell(
                        onTap: () {
                          controller.addTotalAmount();
                        },
                        focusColor: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 170),
              child: ElevatedButton(
                onPressed: () {
                  controller.addProductToCart(product.productId!, controller.totalUnits.value, controller.sizeSelected.value+1);
                  context.pop();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                            "Add s/ ${controller.totalPrice.value!.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontSize),
                          ))
                    ],
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _onBackButton extends StatelessWidget {
  const _onBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: -10,
      child: RawMaterialButton(
        fillColor: Colors.white,
        padding: EdgeInsets.all(5),
        onPressed: () {
          context.goNamed("main");
        },
        shape: const CircleBorder(),
        elevation: 2,
        child: Icon(
          Icons.arrow_back,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
