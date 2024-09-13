import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_meal/screens/leftover_recipes/leftover_recipes_screen.dart';
import 'package:smart_meal/screens/recipes/quick_foods_screen.dart';
import 'package:smart_meal/screens/recipes/recipe_screen.dart';
import '../../../models/category.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.currentCat,
  });

  final String currentCat;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          catgories.length,
          (index) => GestureDetector(
            onTap: () {
              if (catgories[index] == 'Leftover Recipes') {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (c) => const LeftoverRecipesScreen()));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: currentCat == catgories[index]
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onPrimary.withOpacity(.3),
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: const EdgeInsets.only(right: 20),
              child: Text(
                catgories[index],
                style: TextStyle(
                  color: currentCat == catgories[index]
                      ? Theme.of(context).colorScheme.onSecondary.withOpacity(1)
                      : Theme.of(context).colorScheme.surface.withOpacity(1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
