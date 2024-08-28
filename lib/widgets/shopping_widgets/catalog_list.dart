import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../models/catalog.dart';
import '../../screens/shopping/detail_page.dart';
import 'add_to_cart.dart';
import 'catalog_image.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: CatalogModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModel.items[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(catalog: catalog)));
          },
          child: CatalogItem(catalog: catalog),
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
    // Adjusting size using percentages for responsiveness
    final imageSize = context.safePercentHeight * 20;
    final cardHeight = context.safePercentHeight * 23;
    final buttonWidth = context.safePercentWidth * 20;
    final buttonHeight = context.safePercentHeight * 5;

    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(catalog.id.toString()),
            child: CatalogImage(image: catalog.image).wh(imageSize, imageSize),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                catalog.name.text.bold.color(context.theme.colorScheme.secondary).lg.make(),
                catalog.desc.text.textStyle(context.captionStyle).ellipsis.maxLines(3).make().py(5),
                10.heightBox,
                ButtonBar(
                  buttonTextTheme: ButtonTextTheme.normal,
                  buttonPadding: EdgeInsets.zero,
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "€ ${catalog.prices}".text.color(Theme.of(context).colorScheme.primary).lg.bold.make(),
                    AddToCart(catalog: catalog).wh(buttonWidth, buttonHeight),
                  ],
                ).pOnly(right: 8),
              ],
            ),
          ),
        ],
      ),
    ).color((Theme.of(context).colorScheme.onSecondary)).rounded.square(cardHeight).make().py(17);
  }
}
