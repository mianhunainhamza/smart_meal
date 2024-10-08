import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/catalog.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/custom_floating_button.dart';
import 'cart_page.dart';
import 'components/catalog_list.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => ShoppingPageState();
}

class ShoppingPageState extends State<ShoppingPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 1));
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decodeData = jsonDecode(catalogJson);
    final productsData = decodeData["products"];
    setState(() {
      CatalogModel.items = List.from(productsData)
          .map<Item>((item) => Item.fromMap(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("Products"),
        ),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
          fontSize: 25,
        ),
        centerTitle: true,
      ),
      floatingActionButton: cartProvider.ingredients.isNotEmpty || cartProvider.items.isNotEmpty
          ? CustomFloatingAction(cartProvider: cartProvider)
          : Container(),
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (CatalogModel.items.isNotEmpty)
              const Expanded(child: CatalogList())
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.only(bottom: 20),
                        height: 100,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

