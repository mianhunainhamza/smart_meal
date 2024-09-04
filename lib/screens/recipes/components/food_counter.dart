import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FoodCounter extends StatelessWidget {
  final int currentNumber;
  final Function() onAdd;
  final Function() onRemove;
  final Function(int) onUpdateNumber;

  const FoodCounter({
    super.key,
    required this.currentNumber,
    required this.onAdd,
    required this.onRemove,
    required this.onUpdateNumber,
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
          GestureDetector(
            onTap: () => _showInputDialog(context),
            child: SizedBox(
              width: 30,
              child: Center(
                child: Text(
                  "$currentNumber",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
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

  // Method to show input dialog
  void _showInputDialog(BuildContext context) {
    TextEditingController controller = TextEditingController(text: "$currentNumber");
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(
            child: Text(
              "Enter Amount",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: "Enter number",
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                int? newNumber = int.tryParse(controller.text);
                if (newNumber != null && newNumber > 0) {
                  onUpdateNumber(newNumber);
                }
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "OK",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}
