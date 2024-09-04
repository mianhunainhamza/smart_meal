import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/catalog.dart';
import 'components/add_to_cart.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.catalog});

  final Item catalog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ButtonBar(
          buttonPadding: EdgeInsets.zero,
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "€ ${catalog.prices}",
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            AddToCart(catalogItem: catalog)
          ],
        ).paddingSymmetric(horizontal: 30, vertical: 10),
      ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            size: 30,
            color: Theme.of(context).colorScheme.onPrimary,
            CupertinoIcons.back,
          ),
        ),
        backgroundColor: Theme.of(context).canvasColor.withOpacity(.1),
      ),
      backgroundColor: Theme.of(context).canvasColor.withOpacity(.9),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(catalog.id.toString()),
              child: SizedBox(
                width: double.infinity,
                height: Get.height * .3,
                child: Image.asset(
                  catalog.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        catalog.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        catalog.desc,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ).paddingAll(20),
                      const SizedBox(height: 10),
                    ],
                  ).paddingSymmetric(vertical: 64),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
