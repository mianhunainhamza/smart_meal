import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FoodCounter extends StatelessWidget {
  final int currentNumber;
  final Function() onAdd;
  final Function() onRemove;

  const FoodCounter({
    super.key,
    required this.currentNumber,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.5,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onRemove,
            icon: Icon(
              Iconsax.minus,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "$currentNumber",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: onAdd,
            icon: Icon(
              Iconsax.add,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
