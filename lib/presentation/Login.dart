
import 'dart:async';
import 'dart:convert';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/coffee_login.png',
                    height: 150,
                  ),
                ),
              _loginCard()
              ],
            )
          ],
        ),
      ),
      ]
    );
  }
}

class _loginCard extends StatelessWidget {
  const _loginCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                  fontWeight: FontWeight.bold
                ),
                ),
                Text(
                "Welcome back!",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  color: Colors.grey
                ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  hintText: 'Enter email',
                  prefixIcon: Icon(Icons.email)
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  hintText: 'Enter password',
                  prefixIcon: Icon(Icons.lock)
                ),
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
                        onChanged: (value){
          
                        },
                        ),
                      Text(
                        "Remember me",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Theme.of(context).textTheme.labelMedium!.fontSize
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.labelMedium!.fontSize
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: (){}, 
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 40),
                  backgroundColor: Theme.of(context).primaryColor,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {},
                        child: Text("Sign up", style: TextStyle(color: Theme.of(context).primaryColor),)
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