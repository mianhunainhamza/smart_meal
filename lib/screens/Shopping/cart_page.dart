import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/catalog.dart';
import '../../models/ingredient.dart';
import '../../providers/cart_provider.dart';
import 'delivery_details.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
    final totalItemPrice = cart.totalPrice;
    final totalIngredientPrice = cart.totalIngredientPrice;
    final totalPrice = totalItemPrice + totalIngredientPrice;

    return cart.items.isEmpty && cart.ingredients.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "€${totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 24,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const DetailsPage()),
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

class _CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final itemsAndIngredients = [...cart.items, ...cart.ingredients];

    return itemsAndIngredients.isEmpty
        ? const Center(
            child: Text("Nothing to show here", style: TextStyle(fontSize: 18)),
          )
        : ListView.builder(
            itemCount: itemsAndIngredients.length,
            itemBuilder: (context, index) {
              final itemOrIngredient = itemsAndIngredients[index];
              final isItem = itemOrIngredient is Item;

              return CartItemRow(
                itemOrIngredient: itemOrIngredient,
                isItem: isItem,
              );
            },
          );
  }
}

class CartItemRow extends StatefulWidget {
  final dynamic itemOrIngredient;
  final bool isItem;

  const CartItemRow({
    super.key,
    required this.itemOrIngredient,
    required this.isItem,
  });

  @override
  CartItemRowState createState() => CartItemRowState();
}

class CartItemRowState extends State<CartItemRow> {
  bool _isEditing = false;
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _quantityController.text = widget.isItem
        ? (widget.itemOrIngredient as Item).name.toString()
        : (widget.itemOrIngredient as Ingredient).quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit_sharp),
            onPressed: () {
              if (_isEditing) {
                // Update quantity
                if (widget.isItem) {
                  cart.updateItemQuantity(
                    widget.itemOrIngredient as Item,
                    int.parse(_quantityController.text),
                  );
                } else {
                  cart.updateIngredientQuantity(
                    widget.itemOrIngredient as Ingredient,
                    int.parse(_quantityController.text),
                  );
                }
                setState(() {
                  _isEditing = false;
                });
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
            },
          ),
          Expanded(
            child: _isEditing
                ? TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black.withOpacity(.3))
                      ),
                      labelText: 'Quantity',
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Optionally handle changes here
                    },
                  )
                : Text(
              style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                    widget.isItem
                        ? widget.itemOrIngredient.name.toString()
                        : "${(widget.itemOrIngredient as Ingredient).name} ${(widget.itemOrIngredient as Ingredient).quantity}${(widget.itemOrIngredient as Ingredient).unit}",
                  ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () {
              if (widget.isItem) {
                cart.removeItem(widget.itemOrIngredient);
              } else {
                cart.removeIngredientItem(
                    widget.itemOrIngredient as Ingredient);
              }

              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: const Text('Item has been removed'),
              //     backgroundColor: Theme.of(context).colorScheme.primary,
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
