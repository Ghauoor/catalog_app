import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/core/store.dart';
import 'package:flutter_catalog/models/cart.dart';
import 'package:flutter_catalog/pages/cart_page.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

import '../models/catalog.dart';
import '../widgets/home_widgets/catalog_header.dart';
import '../widgets/home_widgets/catalog_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = 'https://api.jsonbin.io/b/625c9285bc312b30ebe88694';

  @override
  //get the before running the build method
  void initState() {
    super.initState();
    loadData();
  }

  // Decoding data from json
  void loadData() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    // final catalogJson =
    //     await rootBundle.loadString('assets/files/catalog.json');

    final response = await http.get(Uri.parse(url));
    final catalogJson = response.body;
    // print(catalogJson);
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        floatingActionButton: VxBuilder(
          mutations: const {AddMutation, RemoveMutation},
          builder: (BuildContext context, store, VxStatus? status) =>
              FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            ),
            backgroundColor: context.theme.buttonColor,
            child: const Icon(
              CupertinoIcons.shopping_cart,
              color: Colors.white,
            ),
          ).badge(
            color: Vx.white,
            size: 20,
            count: _cart.items.length,
            textStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: context.canvasColor,
        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CatalogHeader(),
                if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                  const CatalogList().py16().expand()
                else
                  const CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ).centered().expand()
              ],
            ),
          ),
        ));
  }
}
