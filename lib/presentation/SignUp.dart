
import 'dart:async';
import 'dart:convert';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatelessWidget {
  const SignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Card(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Enter name'
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Enter email'
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Enter password'
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Confirm password'
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}