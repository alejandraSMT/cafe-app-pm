import 'dart:async';
import 'dart:convert';
// ignore: unnecessary_import
import 'package:cafe_app/presentation/profile/ProfileController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:go_router/go_router.dart';

class SettingsProfile extends StatefulWidget {
  SettingsProfile({
    super.key,
  });

  @override
  State<SettingsProfile> createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  ProfileController controller = Get.put(ProfileController());
  final scrollContoller = ScrollController();

  @override
  void initState() {
    controller.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style =
        theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);
    return Scaffold(
        appBar: AppBar(
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
            "Settings",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: Obx(() => controller.loaded.value
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          minHeight: 180, maxHeight: 200, maxWidth: 250),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            constraints: const BoxConstraints(
                                maxWidth: 120, minHeight: 120),
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZrU-vpqXy8lk55H4d9_4bvh9Su7DfvBdyLegwZsLkcQ&s",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            "${controller.userData.name} ${controller.userData.lastname}",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "General",
                          style: style,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.changeEditingState();
                          },
                          child: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: ListView(
                        controller: scrollContoller,
                        shrinkWrap: true,
                        children: [
                          ListTile(
                              leading: Icon(Icons.person),
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Text(
                                controller.userData.name,
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .fontSize,
                                    fontWeight: FontWeight.w500),
                              )),
                          ListTile(
                              leading: Icon(Icons.person),
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Text(
                                controller.userData.lastname,
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .fontSize,
                                    fontWeight: FontWeight.w500),
                              )),
                          ListTile(
                              leading: Icon(Icons.email),
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Text(
                                controller.userData.email,
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .fontSize,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Password",
                      style: style,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: ListTile(
                          leading: Icon(Icons.lock),
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text(
                            "Change password",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .fontSize,
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ))
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                  )
                ],
              )));
  }
}
