// ignore: unused_import
import 'dart:async';
import 'dart:convert';

import 'package:cafe_app/Product.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:device_preview/device_preview.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = ThemeData(
      colorSchemeSeed: Color.fromARGB(255, 177, 127, 77),
    );

    return MaterialApp(
      theme: appTheme,
      home: const Scaffold(
        body: AppView(),
      ),
    );
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

  Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();
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
        page = const Center(
          child: Text("PROFILE"),
        );

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

class MapView extends StatefulWidget {
  const MapView({super.key});

  static const LatLng _center =
      const LatLng(37.42796133580664, -122.085749655962);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> googleMapController = Completer();
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Locales",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold
          ),
          ),
      ),
        body: Center(
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          googleMapController.complete(controller);
        },
        initialCameraPosition: const CameraPosition(
            target: LatLng(37.42796133580664, -122.085749655962), zoom: 15.0),
        mapType: MapType.normal,
        zoomControlsEnabled: true,
        compassEnabled: true,
        myLocationButtonEnabled: true,
      ),
    )
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void getNext() {}

  List<Product> popular = getPopularProducts();

  static List<Product> getPopularProducts() {
    const data = [
      {
        "name": "Honey almondmilk cold brew brew brew brew brew brew",
        "price": "s/14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355"
      },
      {
        "name": "Honey almondmilk cold brew",
        "price": "s/14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355"
      },
      {
        "name": "Honey almondmilk cold brew",
        "price": "s/14.25",
        "description": "Cold brew lightly sweetenet",
        "image":
            "https://londonschoolofcoffee.com/cdn/shop/products/LSC_Product_Pic_600_x_469_9_1_600x490.png?v=1582562355"
      }
    ];
    return data.map<Product>(Product.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.primary, fontWeight: FontWeight.bold);

    var categories = ["Hot Coffee", "Iced Coffee", "Chocolate", "Signature"];

    var selected = 0;
    var colorCard = Colors.white70;

    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(style: style),
                    const Text(
                      "Categories",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5))
                  ]),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 320.0,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 3.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = index;
                      });
                      print("CLICKEO $selected");
                    },
                    child: Card(
                      color: selected == index
                          ? Theme.of(context).primaryColor
                          : colorCard,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      elevation: null,
                      shadowColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              constraints:
                                  BoxConstraints.expand(height: 45, width: 40),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Icon(
                                Icons.coffee,
                                size: 20,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(categories[index])
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: categories.length,
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Popular drinks",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        ProductCard(popular: popular, index: index),
                    childCount: popular.length))
          ],
        ));
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.popular,
    required this.index,
  });

  final List<Product> popular;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 100),
      child: Card(
        elevation: null,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.transparent,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Placeholder(
                fallbackWidth: 100,
                fallbackHeight: 100,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      "${popular[index].name}",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Container(
                      constraints: BoxConstraints(maxWidth: 200),
                      child: Text(
                        "${popular[index].description}",
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize),
                        overflow: TextOverflow.ellipsis,
                      )),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "${popular[index].price}",
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .fontSize),
                          overflow: TextOverflow.ellipsis,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 0,
                          fillColor: Theme.of(context).primaryColor,
                          shape: CircleBorder(),
                          constraints: BoxConstraints(
                              maxHeight: 35,
                              maxWidth: 35,
                              minHeight: 20,
                              minWidth: 20),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                        )
                      ],
                    ),
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

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.style,
  });

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Hola Alejandra",
          style: style,
        ),
        const Spacer(
          flex: 1,
        ),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.white70,
          shape: const CircleBorder(),
          elevation: 2,
          child: const Icon(
            Icons.person,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
