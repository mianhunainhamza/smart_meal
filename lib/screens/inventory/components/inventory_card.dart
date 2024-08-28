import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../models/inventory_item.dart';

class InventoryCard extends StatelessWidget {
  final InventoryItem item;
  final bool isRemoving;
  final int selectedQuantity;
  final Function(int)? onSelectQuantity;
  final Function()? onRemove;
  final Function()? onSelectAll;
  final double height;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;

  const InventoryCard({
    super.key,
    required this.item,
    required this.isRemoving,
    required this.selectedQuantity,
    this.onSelectQuantity,
    this.onRemove,
    this.onSelectAll, required this.height, required this.horizontalPadding, required this.verticalPadding, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle item tap
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(item.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: 3),
                child: Text(
                  item.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(.9),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Date Added: ${item.dateAdded}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      "Expiry Date: ${item.expiryDate}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent.withOpacity(.7),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      "Quantity: ${item.quantity}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      "Price: \$${item.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    if (item.details != null)
                      Text(
                        "Details: ${item.details}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
              if (isRemoving)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Iconsax.minus_square, color: Colors.redAccent),
                            onPressed: () {
                              if (selectedQuantity > 0) {
                                onSelectQuantity!(selectedQuantity - 1);
                              }
                            },
                          ),
                          Text(
                            'Selected: $selectedQuantity',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.add_square, color: Colors.green),
                            onPressed: () {
                              if (selectedQuantity < item.quantity) {
                                onSelectQuantity!(selectedQuantity + 1);
                              }
                            },
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: onSelectAll,
                        child: Text(
                          'Select All',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
