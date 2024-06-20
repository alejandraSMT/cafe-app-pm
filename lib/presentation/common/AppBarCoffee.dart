import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarCoffee extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;

  AppBarCoffee({
    required this.title
  }) : preferredSize = Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            title,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        );
  }
}