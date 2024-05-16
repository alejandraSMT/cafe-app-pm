// ignore: unused_import
import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/presentation/add-card/AddCard.dart';
import 'package:cafe_app/presentation/detail_product/DetailProduct.dart';
import 'package:cafe_app/presentation/login/Login.dart';
import 'package:cafe_app/presentation/cart/ShoppingCart.dart';
import 'package:cafe_app/presentation/order-detail/OrderDetail.dart';
import 'package:cafe_app/presentation/select-payment/SelectPayment.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'presentation/home/HomePage.dart';
import 'presentation/map/MapView.dart';
import 'presentation/profile/Profile.dart';
import 'package:cafe_app/presentation/signup/SignUp.dart';
//import 'package:device_preview/device_preview.dart';

void main() {
  runApp(const MainApp());
}

final _router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          name: 'main',
          path: '/',
          builder: (context, state) => const Scaffold(
            body: AppView(),
          ),
        ),
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => Scaffold(
            body: Login(),
          ),
        ),
        GoRoute(
          name: 'signUp',
          path: '/signUp',
          builder: (context, state) => const Scaffold(
            body: SignUp(),
          ),
        ),
        GoRoute(
          name: 'shoppingCart',
          path: '/shoppingCart',
          builder: (context, state) => const Scaffold(
            body: ShoppingCart(),
          ),
        ),
        GoRoute(
          name: 'detailProduct',
          path: '/detailProduct/:id',
          builder: (context, state) => Scaffold(
            body: DetailProduct(index: state.pathParameters["id"]!,),
          ),
        ),
        GoRoute(
          name: 'orderDetail',
          path: '/orderDetail',
          builder: (context, state) => Scaffold(
            body: OrderDetail(),
          ),
        ),
        GoRoute(
          name: 'selectPayment',
          path: '/selectPayment',
          builder: (context, state) => Scaffold(
            body: SelectPayment(),
          ),
        ),
        GoRoute(
          name: 'addCard',
          path: '/addCard',
          builder: (context, state) => Scaffold(
            body: AddCard(),
          ),
        )
      ],
    );

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = ThemeData(
      colorSchemeSeed: Color.fromARGB(255, 177, 127, 77),
    );

    return MaterialApp.router(
      theme: appTheme,
      routerConfig: _router,
    );
    /*return MaterialApp(
      theme: appTheme,
      home: const Scaffold(
        body: AppView(),
      ),
    );*/
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int currentPage = 0;

  Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (currentPage) {
      case 0:
        page = const HomePage();
        break;

      case 1:
        page = MapView();
        break;
      case 2:
        page = Profile();

      default:
        throw UnimplementedError("no widget for $currentPage");
    }

    return Scaffold(
      body: SafeArea(child: page),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => {
          setState(() {
            currentPage = value;
          })
        },
        selectedIndex: currentPage,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.map), label: "Map"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}