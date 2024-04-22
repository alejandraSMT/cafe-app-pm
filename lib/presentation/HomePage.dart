import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/Product.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  List<Product> popular = getPopularProducts();

  static List<Product> getPopularProducts() {
    const data = [
      {
        "name": "Honey almondmilk cold brew brew brew brew brew brew",
        "price": "14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355"
      },
      {
        "name": "Honey almondmilk cold brew",
        "price": "14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355"
      },
      {
        "name": "Honey almondmilk cold brew",
        "price": "14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355"
      }
    ];
    return data.map<Product>(Product.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.primary, fontWeight: FontWeight.bold);

    var categories =
        ["Hot Coffee", "Iced Coffee", "Chocolate", "Signature"].toList();

    var selected = 0;
    var colorCard = Colors.white70;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(style: style),
                const Text(
                  "Categories",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5))
              ]),
          Container(
            constraints: BoxConstraints(maxHeight: 60),
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      color: selected == index
                          ? Theme.of(context).primaryColor
                          : colorCard,
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
                                constraints:
                                    BoxConstraints.expand(height: 45, width: 40),
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
                              Text(categories[index])
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: categories.length),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Here category name!",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductCard(popular: popular, index: index);
                },
                separatorBuilder: (context, index) => Divider(thickness: 0,color: Colors.transparent,),
                itemCount: popular.length
              ),
          )
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.popular,
    required this.index,
  });

  final List<Product> popular;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 100),
      child: Card(
        elevation: null,
        shadowColor: Colors.transparent,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 80),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Image.network(
                  popular[index].image,
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
                    child: Text(
                      "${popular[index].name}",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Container(
                      constraints: BoxConstraints(maxWidth: 200),
                      child: Text(
                        "${popular[index].description}",
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize),
                        overflow: TextOverflow.ellipsis,
                      )),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "s/ ${popular[index].price}",
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .fontSize),
                          overflow: TextOverflow.ellipsis,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
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

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.style,
  });

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Hello Alejandra",
          style: style,
        ),
        const Spacer(
          flex: 1,
        ),
        RawMaterialButton(
          padding: EdgeInsets.all(5),
          onPressed: () {
            context.goNamed("shoppingCart");
          },
          shape: const CircleBorder(),
          elevation: 2,
          child: const Icon(Icons.shopping_cart),
        ),
      ],
    );
  }
}
