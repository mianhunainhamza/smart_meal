import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../models/inventory_item.dart';

class InventoryCard extends StatelessWidget {
  final InventoryItem item;
  final bool isRemoving;
  final int selectedQuantity;
  final void Function(int) onSelectQuantity;
  final void Function() onRemove;
  final void Function() onSelectAll;
  final double height;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;

  const InventoryCard({
    super.key,
    required this.item,
    required this.isRemoving,
    required this.selectedQuantity,
    required this.onSelectQuantity,
    required this.onRemove,
    required this.onSelectAll,
    required this.height,
    required this.width,
    required this.horizontalPadding,
    required this.verticalPadding,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height,
                width: width,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(item.image, fit: BoxFit.contain),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
                child: Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  '${item.quantity} available',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 5),
                child: Text(
                  'Price: \$${item.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 5),
                    Text(
                      'Added: ${item.dateAdded}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.red[600], size: 16),
                    const SizedBox(width: 5),
                    Text(
                      'Expires: ${item.expiryDate}',
                      style: TextStyle(fontSize: 12, color: Colors.red[600]),
                    ),
                  ],
                ),
              ),
              if (item.details != null && item.details!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 5),
                  child: Text(
                    'Details: ${item.details}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              if (isRemoving)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Iconsax.minus_square, color: Colors.redAccent),
                            onPressed: () {
                              if (selectedQuantity > 0) {
                                onSelectQuantity(selectedQuantity - 1);
                              }
                            },
                          ),
                          Text(
                            'Selected: $selectedQuantity',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.add_square, color: Colors.green),
                            onPressed: () {
                              if (selectedQuantity < item.quantity) {
                                onSelectQuantity(selectedQuantity + 1);
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
