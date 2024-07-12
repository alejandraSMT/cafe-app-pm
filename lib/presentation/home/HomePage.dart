import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/presentation/cart/ShoppingCartController.dart';
import 'package:cafe_app/presentation/common/LoadingIndicator.dart';
import 'package:cafe_app/presentation/home/HomePageController.dart';
import 'package:cafe_app/presentation/profile/ProfileController.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void getNext() {}

  Color colorCard = Colors.white70;
  HomePageController controller = Get.put(HomePageController());
  ShoppingCartController cartController = Get.put(ShoppingCartController());
  @override
  void initState() {
    controller.onLoad(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.primary, fontWeight: FontWeight.bold);

    final scrollContoller = ScrollController();
    //var categories = ["Hot Coffee", "Iced Coffee", "Chocolate", "Signature"].toList();

    return Obx(() => controller.loaded.value
        ? SingleChildScrollView(
            controller: scrollContoller,
            physics: ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(
                          style: style,
                          cartController: cartController,
                          controller: controller,
                        ),
                        Obx(() => controller.hasActiveOrder.value
                            ? Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.push(
                                          "/activeOrder/${controller.activeOrderId}");
                                      print(
                                          "CLICK A ORDEN: ${controller.activeOrderId}");
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        constraints: BoxConstraints(
                                            minWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            minHeight: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withAlpha(10),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    height: 120,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffECE1D0),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    100))),
                                                  ),
                                                  Image.asset(
                                                      'assets/images/coffee-pending-order.png',
                                                      fit: BoxFit.contain)
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Pending order",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall!
                                                              .fontSize),
                                                ),
                                                Text(
                                                  "Pick up your order",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelLarge!
                                                              .fontSize),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              )
                            : Container()),
                        const Text(
                          "Categories",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5))
                      ]),
                  Container(
                    constraints: BoxConstraints(maxHeight: 60),
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Obx(() => _tabCategory(
                              categoryName: controller.categories[index].name!,
                              selectedCategory:
                                  controller.selectedCategory.value,
                              categoryId: controller.categories[index].id!,
                              onSelectedChange: () {
                                setState(() {
                                  controller.changeCategorySelected(
                                      controller.categories[index].id!);
                                  controller.setCategoryName(
                                      controller.categories[index].name!);
                                });
                              }));
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: controller.categories.length),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          controller.categoryName.value,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                      child: GridView.count(
                    controller: scrollContoller,
                    crossAxisCount: 2,
                    childAspectRatio: 0.70 / 1,
                    children: List.generate(
                        controller.filteredList.length,
                        (index) => ProductCard(
                              popular: controller.filteredList,
                              index: index,
                              product: controller.filteredList[index],
                            )),
                    shrinkWrap: true,
                  ))
                ],
              ),
            ))
        : LoadingIndicator());
  }
}

class _tabCategory extends StatefulWidget {
  const _tabCategory(
      {super.key,
      required this.categoryName,
      required this.categoryId,
      required this.selectedCategory,
      required this.onSelectedChange});

  final String categoryName;
  final int categoryId;
  final int selectedCategory;
  final VoidCallback onSelectedChange;

  @override
  State<_tabCategory> createState() => _tabCategoryState();
}

class _tabCategoryState extends State<_tabCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelectedChange();
      },
      child: Card(
        color: widget.selectedCategory == widget.categoryId
            ? Theme.of(context).primaryColor
            : Colors.white70,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        elevation: null,
        shadowColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints.expand(height: 45, width: 40),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.coffee,
                    size: 20,
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Text(
                  widget.categoryName,
                  style: TextStyle(
                      color: widget.selectedCategory == widget.categoryId
                          ? Colors.white
                          : Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.popular,
      required this.index,
      required this.product});

  //final List<Product> popular;
  final RxList popular;
  final int index;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/detailProduct/${product.productId!.toString()}");
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        constraints: BoxConstraints(maxWidth: 100),
        child: Card(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  constraints: BoxConstraints(maxHeight: 130),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Image.network(
                    popular[index].image!,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  popular[index].name!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                Text(
                  popular[index].description!,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "s/ ${popular[index].price}",
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          elevation: null,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader(
      {super.key,
      required this.style,
      required this.cartController,
      required this.controller});

  final TextStyle style;
  final ShoppingCartController cartController;
  final HomePageController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Hello, ${controller.userName.value}!",
          style: style,
        ),
        const Spacer(
          flex: 1,
        ),
        RawMaterialButton(
            padding: EdgeInsets.all(5),
            onPressed: () {
              context.push("/shoppingCart");
            },
            shape: const CircleBorder(),
            elevation: 2,
            child: Badge(
                label: cartController.totalItems.value > 0
                    ? Obx(() => Text(
                          textAlign: TextAlign.end,
                          "${cartController.totalItems.value}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                    : null,
                child: Icon(Icons.shopping_cart))),
      ],
    );
  }
}
