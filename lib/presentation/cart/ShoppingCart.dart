import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/models/Product.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({
    super.key,
  });

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  var totalAmount = 0.0;

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
  void initState() {
    popular.forEach((element) {
      totalAmount = totalAmount + double.parse(element.price!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.goNamed("main");
          },
          child: Icon(
          Icons.arrow_back,
          color: Theme.of(context).primaryColor,
        ),
        ),
        title: Text(
          "My cart",
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.separated(
                itemBuilder: (context, index) {
                  return ProductShopping(popular: popular, index: index);
                },
                itemCount: popular.length,
                separatorBuilder: (context, index) => Divider(thickness: 0,color: Colors.transparent,),
                shrinkWrap: true,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                        Spacer(),
                        Text(
                          "s/ ${totalAmount}",
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor)
                        ),
                        onPressed: (){
                          context.goNamed("orderDetail");
                        }, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Complete order",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize
                              ),
                              )
                          ],
                        )
                        ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class ProductShopping extends StatelessWidget {
  const ProductShopping({
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
                  popular[index].image!,
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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
                          "s/ ${popular[index].price}",
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
                                Icons.remove,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            Text("1"),
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