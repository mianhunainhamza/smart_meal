import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_meal/screens/recipes/components/food_card.dart';
import '../../../models/food.dart';

class QuickAndFastList extends StatelessWidget {
  const QuickAndFastList({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.45;
    const cardHeight = 200.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick & Fast",
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(.8),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        // Horizontal scrolling with responsive card size
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              foods.length,
                  (index) => SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FoodCard(food: foods[index])),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
