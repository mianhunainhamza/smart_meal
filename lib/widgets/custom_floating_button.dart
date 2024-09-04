
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../providers/cart_provider.dart';
import '../screens/shopping/cart_page.dart';

class CustomFloatingAction extends StatelessWidget {
  const CustomFloatingAction({
    super.key,
    required this.cartProvider,
  });

  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (c) => const CartPage()),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          child: Icon(
            CupertinoIcons.cart,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Positioned(
          right: 10,
          top: 5,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              maxWidth: 20,
              maxHeight: 25,
            ),
            child: Center(
              child: Text(
                '${cartProvider.items.length + cartProvider.ingredients.length}',
                style: TextStyle(
                  color: Theme.of(context).canvasColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}