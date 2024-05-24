import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/presentation/past-orders/PastOrders.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    const options = {
      "Profile settings": Icons.settings,
      "My orders": Icons.shopping_bag,
      "My cards": Icons.payment,
      "Log out": Icons.logout
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
            Column(
              children: [
                _profileHeader(),
                ...options.entries.map<Widget>((option) {
                  var index = options.keys
                      .toList()
                      .indexWhere((element) => element == option.key);
                  var length = options.entries.toList().length;
                  return Column(
                    children: [
                      if (index == length - 1)
                        Column(
                            children: [Divider(color: Colors.grey, height: 1)]),
                      ListTile(
                        leading: Icon(
                          option.value,
                          color: Colors.grey,
                        ),
                        title: Text(
                          option.key,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                              color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PastOrders(),
                            ),
                          );
                        },
                        style: ListTileStyle.list,
                      )
                    ],
                  );
                }).toList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _profileHeader extends StatelessWidget {
  const _profileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints:
            BoxConstraints(minHeight: 180, maxHeight: 200, maxWidth: 250),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(shape: BoxShape.circle),
              constraints: const BoxConstraints(maxWidth: 120, minHeight: 120),
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZrU-vpqXy8lk55H4d9_4bvh9Su7DfvBdyLegwZsLkcQ&s",
                fit: BoxFit.fill,
              ),
            ),
            Text(
              "Nombre",
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )),
      );
  }
}
