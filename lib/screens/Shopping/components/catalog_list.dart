import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../models/catalog.dart';
import '../../../providers/cart_provider.dart';
import '../detail_page.dart';
import 'add_to_cart.dart';
import 'catalog_image.dart';



class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: CatalogModel.items.length,
          itemBuilder: (context, index) {
            final catalog = CatalogModel.items[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(catalog: catalog),
                  ),
                );
              },
              child: CatalogItem(catalog: catalog),
            );
          },
        );
      },
    );
  }
}




class CatalogItem extends StatelessWidget {
  const CatalogItem({super.key, required this.catalog});
  final Item catalog;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        color: Theme.of(context).canvasColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: Key(catalog.id.toString()),
              child: CatalogImage(image: catalog.image),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Text(
                      catalog.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      catalog.desc,
                    ).paddingSymmetric(vertical: 5),
                    const SizedBox(height: 10),
                    ButtonBar(
                      buttonPadding: EdgeInsets.zero,
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "€ ${catalog.prices}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AddToCart(catalogItem: catalog)
                      ],
                    ).paddingOnly(right: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
