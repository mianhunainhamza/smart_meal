import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/catalog.dart';
import '../../../models/ingredient.dart';
import '../../../providers/cart_provider.dart';

class AddToCart extends StatelessWidget {
  final Item? catalogItem;
  final Ingredient? ingredient;

  const AddToCart({super.key, this.catalogItem, this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final isInCart = catalogItem != null
            ? cartProvider.items.contains(catalogItem)
            : ingredient != null
            ? cartProvider.ingredients.contains(ingredient)
            : false;

        return ElevatedButton(
          onPressed: () {
            if (!isInCart) {
              if (catalogItem != null) {
                cartProvider.addItem(catalogItem!);
              } else if (ingredient != null) {
                cartProvider.addIngredientItem(ingredient!);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 700),
                  content: const Text('Item has been added'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
            } else {
              if (catalogItem != null) {
                cartProvider.removeItem(catalogItem!);
              } else if (ingredient != null) {
                cartProvider.removeIngredientItem(ingredient!);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 700),
                  content: const Text('Item has been removed'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onSecondary),
            shape: WidgetStateProperty.all(const StadiumBorder()),
          ),
          child: isInCart
              ? Icon(Icons.done, color: Theme.of(context).colorScheme.primary, size: 24,)
              : const Icon(CupertinoIcons.cart_badge_plus, color: Colors.black, size: 24,),
        );
      },
    );
  }
}
