import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_meal/screens/recipes/components/add_to_cart_item.dart';
import 'package:smart_meal/screens/recipes/components/cart_item_page.dart';
import 'package:smart_meal/widgets/custom_button.dart';
import '../../models/food.dart';
import '../../models/ingredient.dart';
import '../../providers/cart_provider.dart';
import '../../providers/inventory_provider.dart';
import 'components/food_counter.dart';

class RecipeScreen extends StatefulWidget {
  final Food food;

  const RecipeScreen({super.key, required this.food});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  int currentNumber = 1;

  String calculateQuantity(int baseQuantity) {
    final adjustedQuantity = baseQuantity * currentNumber;
    return '$adjustedQuantity';
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (c) => const CartItemPage()),
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
                  '${cartProvider.recipeItems.length}',
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
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomButton(
                  text: 'Start Cooking',
                  onPressed: () {},
                  isLoading: false,
                  tag: '',
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(.9),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: IconButton(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                onPressed: () {},
                style: IconButton.styleFrom(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 2,
                    ),
                  ),
                ),
                icon: Icon(
                  widget.food.isLiked ? Iconsax.heart5 : Iconsax.heart,
                  color: widget.food.isLiked
                      ? Colors.red
                      : Theme.of(context).colorScheme.tertiary,
                  size: 27,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned(
                  child: Hero(
                    tag: widget.food.name,
                    child: Container(
                      height: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.food.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: const Size(50, 50),
                        ),
                        icon: const Icon(CupertinoIcons.chevron_back),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: const Size(50, 50),
                        ),
                        icon: const Icon(Iconsax.notification),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.width - 50,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondary,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.food.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Iconsax.flash_1,
                        size: 20,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      Text(
                        "${widget.food.cal} Cal",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Text(
                        " · ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Icon(
                        Iconsax.clock,
                        size: 20,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      Text(
                        "${widget.food.time} Min",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Iconsax.star5,
                        color: Theme.of(context).colorScheme.primary,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${widget.food.rate}/5",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "(${widget.food.reviews} Reviews)",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ingredients",
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "How many servings?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      FoodCounter(
                        currentNumber: currentNumber,
                        onAdd: () => setState(() {
                          currentNumber++;
                        }),
                        onRemove: () {
                          if (currentNumber != 1) {
                            setState(() {
                              currentNumber--;
                            });
                          }
                        },
                        onUpdateNumber: (newNumber) => setState(() {
                          currentNumber = newNumber;
                        }), // Handle the number update
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Consumer<InventoryProvider>(
                    builder: (context, inventoryProvider, child) {
                      final List<Ingredient> ingredients = widget.food.ingredients;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var ingredient in ingredients)
                            Column(
                              children: [
                                Divider(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  height: 30,
                                  thickness: 1,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: AssetImage(ingredient.image),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ingredient.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).colorScheme.onPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "${calculateQuantity(ingredient.quantity)} ${ingredient.unit}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).colorScheme.tertiary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    if (inventoryProvider.isItemAvailable(
                                        ingredient.name,
                                        ingredient.quantity * currentNumber))
                                      const Text(
                                        'Available',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    else
                                      Row(
                                        children: [
                                          Tooltip(
                                            message: 'Item or quantity is missing in inventory',
                                            child: Icon(
                                              Icons.error_outline,
                                              size: 25,
                                              color: Colors.red.withOpacity(.8),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          AddToCartItem(buyItem: ingredient)
                                        ],
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          SizedBox(height: Get.height * .1,)
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
