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
    final quantity = widget.isItem
        ? (widget.itemOrIngredient as Item).quantity
        : (widget.itemOrIngredient as Ingredient).quantity;
    _quantityController.text = quantity.toString();
  }

  num _calculateAdjustedPrice(dynamic itemOrIngredient) {
    final isItem = widget.isItem;
    final price = isItem
        ? (itemOrIngredient as Item).prices
        : (itemOrIngredient as Ingredient).price;
    final quantity = isItem
        ? (itemOrIngredient as Item).quantity
        : (itemOrIngredient as Ingredient).quantity ?? 1;
    final unit = isItem
        ? (itemOrIngredient as Item).unit
        : (itemOrIngredient as Ingredient).unit;

    final conversionFactors = {
      'kg': 1000,
      'g': 1,
      'ml': 1,
      'L': 1000,
    };

    if (conversionFactors.containsKey(unit)) {
      if (unit == 'g' || unit == 'ml') {
        return (price / 1000) * quantity;
      } else if (unit == 'kg' || unit == 'L') {
        return price * quantity;
      }
    }

    return price * quantity;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final isItem = widget.isItem;
    final name = isItem
        ? (widget.itemOrIngredient as Item).name
        : (widget.itemOrIngredient as Ingredient).name;
    final quantity = isItem
        ? (widget.itemOrIngredient as Item).quantity
        : (widget.itemOrIngredient as Ingredient).quantity;
    final unit = isItem
        ? (widget.itemOrIngredient as Item).unit
        : (widget.itemOrIngredient as Ingredient).unit;
    final adjustedPrice = _calculateAdjustedPrice(widget.itemOrIngredient);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          leading: IconButton(
            icon:
            Icon(_isEditing ? Icons.check : Icons.edit, color: Colors.blue),
            onPressed: () {
              if (_isEditing) {
                // Update quantity
                final quantity = int.tryParse(_quantityController.text) ?? 0;
                if (widget.isItem) {
                  cart.updateItemQuantity(
                    widget.itemOrIngredient as Item,
                    quantity,
                  );
                } else {
                  cart.updateIngredientQuantity(
                    widget.itemOrIngredient as Ingredient,
                    quantity,
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
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: _isEditing
              ? Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black.withOpacity(.2))),
                  labelText: 'Quantity',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black.withOpacity(.1))),
                ),
              ),
            ),
          )
              : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Qty: $quantity $unit',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '€${adjustedPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline,
                    color: Colors.red),
                onPressed: () {
                  if (widget.isItem) {
                    cart.removeItem(widget.itemOrIngredient);
                  } else {
                    cart.removeIngredientItem(
                        widget.itemOrIngredient as Ingredient);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


