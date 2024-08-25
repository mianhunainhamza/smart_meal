import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../models/food.dart';
import '../components/quick_foods_screen.dart';
import '../components/recipe_screen.dart';

class QuickAndFastList extends StatelessWidget {
  const QuickAndFastList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Quick & Fast",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(.8),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => Get.to(const QuickFoodsScreen(),
                  transition: Transition.cupertino),
              child: const Text("View all"),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              foods.length,
              (index) => GestureDetector(
                onTap: () => Get.to(RecipeScreen(food: foods[index])),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 200,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: foods[index].name,
                            child: Container(
                              width: double.infinity,
                              height: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(foods[index].image),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            foods[index].name,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(.9),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.flash_1,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(
                                "${foods[index].cal} Cal",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const Text(
                                " · ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const Icon(
                                Iconsax.clock,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(
                                "${foods[index].time} Min",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        top: 1,
                        right: 1,
                        child: IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(.9),
                            fixedSize: const Size(30, 30),
                          ),
                          iconSize: 20,
                          icon: const Icon(Iconsax.heart),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
