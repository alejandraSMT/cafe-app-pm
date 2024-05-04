import 'dart:async';
import 'dart:convert';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import './LoginController.dart';

class Login extends StatelessWidget {
  Login({
    super.key,
  });

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/LOGO_NO-TEXT.png',
                    height: 150,
                  ),
                ),
                _loginForm(controller: controller)
              ],
            )
          ],
        ),
      ),
    ]);
  }
}

class _loginForm extends StatelessWidget {
  const _loginForm({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          elevation: 0,
          color: Theme.of(context).primaryColor.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Welcome back!",
                  style: TextStyle(
                      fontSize: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .fontSize,
                      color: Colors.grey),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10)),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(25))),
                      hintText: 'Enter email',
                      prefixIcon: Icon(Icons.email)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  controller: controller.passController,
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(25))),
                      hintText: 'Enter password',
                      prefixIcon: Icon(Icons.lock)),
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {},
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .fontSize),
                        ),
                      ],
                    ),
                    Text(
                      "Forgot password?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .fontSize),
                    ),
                  ],
                ),
                Obx(() => Text(
                  controller.message.string,
                  style: TextStyle(
                    color: controller.messageColor.value
                  ),
                )),
                SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () {
                      controller.login(context);
                      //context.goNamed('main');
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(300, 40),
                        backgroundColor:
                            Theme.of(context).primaryColor,
                        textStyle: TextStyle(color: Colors.white)),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    )),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          context.goNamed('main');
                        },
                        child: GestureDetector(
                          onTap: () => context.goNamed('signUp'),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color:
                                    Theme.of(context).primaryColor),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
