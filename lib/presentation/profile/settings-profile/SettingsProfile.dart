import 'dart:async';
import 'dart:convert';
// ignore: unnecessary_import
import 'package:cafe_app/presentation/common/AppBarCoffee.dart';
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
    controller.resetEditingState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style =
        theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);
    var styleSubheads =
        theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500);
    return Scaffold(
        appBar: AppBarCoffee(title: "Settings"),
        body: Obx(() => controller.loaded.value
            ? (Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Obx(() => !controller.editing.value
                        ? Row(
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
                          )
                        : Container()),
                    Obx(() => !controller.editing.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                child: ListView(
                                  controller: scrollContoller,
                                  shrinkWrap: true,
                                  children: [
                                    ListTile(
                                        leading: Icon(Icons.person),
                                        titleAlignment:
                                            ListTileTitleAlignment.center,
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
                                        titleAlignment:
                                            ListTileTitleAlignment.center,
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
                                        titleAlignment:
                                            ListTileTitleAlignment.center,
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: ListTile(
                                    onTap: () {
                                      context.push("/changePassword");
                                    },
                                    leading: Icon(Icons.lock),
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
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
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Name:",
                                  style: styleSubheads,
                                ),
                              ),
                              TextField(
                                readOnly: true,
                                enabled: false,
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    hintText: controller.userData.name,
                                    prefixIcon: Icon(Icons.person)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 5.0),
                                child: Text(
                                  "Lastname:",
                                  style: styleSubheads,
                                ),
                              ),
                              TextField(
                                controller: controller.lastname,
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    prefixIcon: Icon(Icons.person)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 5.0),
                                child: Text(
                                  "Email:",
                                  style: styleSubheads,
                                ),
                              ),
                              TextField(
                                controller: controller.emailAddress,
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    hintText: 'Enter email',
                                    prefixIcon: Icon(Icons.email)),
                              ),
                              Obx(() => controller.errorMessage.value != ''
                                  ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            controller.errorMessage.value,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container()),
                              Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.white)),
                                          onPressed: () {
                                            controller.changeEditingState();
                                            controller.resetValues();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .fontSize),
                                              )
                                            ],
                                          )),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Theme.of(context)
                                                          .primaryColor)),
                                          onPressed: () {
                                            controller.updateChanges(context);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Confirm",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .fontSize),
                                              )
                                            ],
                                          )),
                                    ],
                                  )),
                            ],
                          ))
                  ],
                ),
              ))
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
