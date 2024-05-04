
import 'dart:async';
import 'dart:convert';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SignUp extends StatelessWidget {
  const SignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
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
            _signUpCard()
            ],
          )
        ],
      ),
    );
  }
}

class _signUpCard extends StatelessWidget {
  const _signUpCard({
    super.key,
  });

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
                  "Sign Up",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    color: Colors.grey
                  ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    hintText: 'Enter name',
                    prefixIcon: Icon(Icons.person)
                  ),
                ),
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
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    hintText: 'Enter password',
                    prefixIcon: Icon(Icons.lock)
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    hintText: 'Confirm password',
                    prefixIcon: Icon(Icons.lock)
                  ),
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
                      Text("Already have an account?"),
                      TextButton(
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () => {context.goNamed('login')},
                            child: Text("Login", style: TextStyle(color: Theme.of(context).primaryColor),),
                          )
                      )
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