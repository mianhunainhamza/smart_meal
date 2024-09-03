import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_meal/models/ingredient.dart';
import '../../../models/food.dart';
import '../../../providers/cart_provider.dart';

class AddToCartItem extends StatelessWidget {
  final Ingredient buyItem;

  const AddToCartItem({super.key,required this.buyItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final isInCart = cartProvider.recipeItems.contains(buyItem);

        return ElevatedButton(
          onPressed: () {
            if (!isInCart) {
              cartProvider.addIngredientItem(buyItem);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 700),
                  content: const Text('Item has been added'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 700),
                  content: const Text('Item already added'),
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
              ? Icon(Icons.done, color: Theme.of(context).colorScheme.primary,size: 24,)
              : const Icon(CupertinoIcons.cart_badge_plus, color: Colors.black,size: 24,),
        );
      },
    );
  }
}
