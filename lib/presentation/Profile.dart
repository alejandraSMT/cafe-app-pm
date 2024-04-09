import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/Product.dart';
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
      "Configuration": Icons.accessibility,
      "My orders": Icons.shopping_bag,
      "My cards": Icons.payment,
      "Log out": Icons.logout
    };

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
            Column(
              children: [
                Stack(children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: 150),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.8)),
                  ),
                  _profileHeader()
                ]),
                /*Text("Profile",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.displaySmall!.fontSize,
                        fontWeight: FontWeight.bold)),*/
                //_profileHeader(),
                ...options.entries.map<Widget>((option) {
                  var index = options.keys
                      .toList()
                      .indexWhere((element) => element == option.key);
                  var length = options.entries.toList().length;
                  return Column(
                    children: [
                      if (index == length - 1)
                        Column(children: [
                          Divider(color: Colors.grey, height: 1)
                        ]),
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
                          print("CLICKEO EN OPCION: $option");
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
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Center(
        child: Container(
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
                constraints:
                    const BoxConstraints(maxWidth: 120, minHeight: 120),
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
        ),
      ),
    );
  }
}