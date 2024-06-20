import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/models/Options.dart';
import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/presentation/past-orders/PastOrders.dart';
import 'package:cafe_app/presentation/profile/ProfileController.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var options = {
      Options(title: "Settings", icon:  Icons.settings, route: "/settingsProfile"),
      Options(title: "My orders", icon: Icons.shopping_bag, route: "/pastOrders"),
      Options(title: "My cards", icon: Icons.payment, route: "/myCards"),
      Options(title: "Log out", icon: Icons.logout)
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
                _profileHeader(controller: controller),
                ...options.map<Widget>((option) {
                  var index = options
                      .toList()
                      .indexWhere((element) => element == option);
                  var length = options.toList().length;
                  return Column(
                    children: [
                      if (index == length - 1)
                        Column(
                            children: [Divider(color: Colors.grey, height: 1)]),
                      ListTile(
                        leading: Icon(
                          option.icon,
                          color: Colors.grey,
                        ),
                        title: Text(
                          option.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                              color: Colors.black),
                        ),
                        onTap: () {
                          if(option.route != null){
                            context.push(option.route!);
                          }else{
                            controller.logout(context);
                          }
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

class _profileHeader extends StatefulWidget {
  const _profileHeader({
    super.key,
    required this.controller
  });

  final ProfileController controller;

  @override
  State<_profileHeader> createState() => _profileHeaderState();
}

class _profileHeaderState extends State<_profileHeader> {
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
              "${widget.controller.userData.name} ${widget.controller.userData.lastname}",
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )),
      );
  }
}
