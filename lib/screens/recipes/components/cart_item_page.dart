import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';
import '../../shopping/delivery_details.dart';

class CartItemPage extends StatelessWidget {
  const CartItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.9),
        title: const Text("Cart", style: TextStyle(fontSize: 24)),
      ),
      body: Column(
        children: [
          Expanded(child: _CartList()),
          const Divider(),
          const _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return cart.recipeItems.isEmpty
        ? const SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "€${cart.totalIngredientPrice.toStringAsFixed(2)}",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 24,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (c) => const DetailsPage()),
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.onSecondary),
              shape: WidgetStateProperty.all(const StadiumBorder()),
            ),
            child: const Text(
              "Confirm",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return cart.recipeItems.isEmpty
        ? const Center(
      child: Text("Nothing to show here", style: TextStyle(fontSize: 18)),
    )
        : ListView.builder(
      itemCount: cart.recipeItems.length,
      itemBuilder: (context, index) {
        final item = cart.recipeItems[index];
        final quantity = item.quantity;
        final unit = item.unit;

        return ListTile(
          leading: const Icon(Icons.done),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () {
              cart.removeIngredientItem(item);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Item has been removed'),
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(1),
                ),
              );
            },
          ),
          title: Text('${item.name} $quantity $unit'),
        );
      },
    );
  }
}

