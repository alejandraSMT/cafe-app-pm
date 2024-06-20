import 'package:cafe_app/presentation/change-password/ChangePasswordController.dart';
import 'package:cafe_app/presentation/common/AppBarCoffee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ChangePasswordController controller = Get.put(ChangePasswordController());

  @override
  void initState() {
    controller.resetValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCoffee(title: "Change password"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              obscureText: true,
              controller: controller.newPassword,
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  hintText: 'Enter password',
                  prefixIcon: Icon(Icons.lock)),
            ),
            SizedBox(height: 20,),
            TextField(
              obscureText: true,
              controller: controller.newPasswordVerify,
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  hintText: 'Confirm new password',
                  prefixIcon: Icon(Icons.lock)),
            ),
            Obx(() => controller.message.value != ""
                ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      controller.message.value,
                      style: TextStyle(color: Colors.red),
                    ),
                )
                : Container()),
            Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          context.pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .fontSize),
                            )
                          ],
                        )),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor)),
                        onPressed: () {
                          controller.changePassword(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      ),
    );
  }
}
