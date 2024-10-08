import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:smart_meal/providers/inventory_provider.dart';
import 'package:smart_meal/screens/recipes/recipe_screen.dart';
import '../../../models/food.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  final int index;
  const FoodCard({super.key, required this.food, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoryProvider>(
      builder: (context, cartProvider, child) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeScreen(food: food, index: index,),
              ),
            );
          },
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: food.name,
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(food.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      food.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(.9),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.flash_1,
                          size: 18,
                          color: Colors.grey,
                        ),
                        Text(
                          "${food.cal} Cal",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
                          " · ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const Icon(
                          Iconsax.clock,
                          size: 18,
                          color: Colors.grey,
                        ),
                        Text(
                          "${food.time} Min",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Iconsax.star5,
                            color: Colors.yellow.shade700, size: 20),
                        const SizedBox(width: 5),
                        Text(
                          "${food.rate}/5",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "(${food.reviews} Reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Positioned(
                  top: 1,
                  right: 1,
                  child: IconButton(
                    onPressed: () {
                      print(food.name);
                      cartProvider.toggleLikeStatus(food);
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(30, 30),
                    ),
                    iconSize: 20,
                    icon: food.isLiked
                        ? const Icon(
                      Iconsax.heart5,
                      color: Colors.red,
                    )
                        : const Icon(Iconsax.heart),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
