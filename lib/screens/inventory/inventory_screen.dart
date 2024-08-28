import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_meal/widgets/custom_button.dart';
import '../../models/inventory_item.dart';
import 'components/inventory_card.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  InventoryScreenState createState() => InventoryScreenState();
}

class InventoryScreenState extends State<InventoryScreen> {
  List<InventoryItem> inventory = [
    InventoryItem(
      name: 'Apple',
      image:
      'assets/images/apple.png',
      dateAdded: '10-12-2024',
      expiryDate: '20-12-2024',
      quantity: 10,
      price: 1.50,
      details: 'Fresh and organic',
    ),
    InventoryItem(
      name: 'Banana',
      image:
      'assets/images/banana.png',
      dateAdded: '12-10-2024',
      expiryDate: '12-11-2024',
      quantity: 20,
      price: 1.20,
    ),
    InventoryItem(
      name: 'Orange',
      image:
      'assets/images/orange.png',
      dateAdded: '10-11-2024',
      expiryDate: '20-11-2024',
      quantity: 15,
      price: 2.00,
    ),
  ];

  bool isRemoving = false;
  bool isGridView = true;
  Map<String, int> selectedItems = {};

  void _addItem(String method) {
    print("Adding item via $method");
  }

  void _toggleRemoveMode() {
    setState(() {
      isRemoving = !isRemoving;
      if (!isRemoving) selectedItems.clear();
    });
  }

  void _toggleItemSelection(InventoryItem item, int selectedQuantity) {
    setState(() {
      if (selectedItems.containsKey(item.name)) {
        selectedItems[item.name] = selectedQuantity;
      } else {
        selectedItems[item.name] = selectedQuantity;
      }
    });
  }

  void _removeSelectedItems() {
    setState(() {
      selectedItems.forEach((itemName, quantity) {
        final item = inventory.firstWhere((item) => item.name == itemName);
        if (item.quantity <= quantity) {
          inventory.remove(item);
        } else {
          item.quantity -= quantity;
        }
      });
      selectedItems.clear();
      isRemoving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Inventory',
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(.9),
                    height: Get.height * .054,
                    textHeight: 16,
                    text: 'Add Item',
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          color: Colors.white,
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Iconsax.barcode),
                                title: const Text('Barcode Scan'),
                                onTap: () => _addItem('Barcode Scan'),
                              ),
                              ListTile(
                                leading: const Icon(Iconsax.keyboard),
                                title: const Text('Manual Input'),
                                onTap: () => _addItem('Manual Input'),
                              ),
                              ListTile(
                                leading: const Icon(Iconsax.code),
                                title: const Text('QR Code'),
                                onTap: () => _addItem('QR Code'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    isLoading: false,
                    tag: '',
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomButton(
                    backgroundColor: isRemoving
                        ? Colors.red.withOpacity(.7)
                        : Theme.of(context).colorScheme.primary.withOpacity(.9),
                    textHeight: 16,
                    height: Get.height * .054,
                    onPressed: _toggleRemoveMode,
                    text: isRemoving ? 'Cancel Remove' : 'Remove Item',
                    tag: "",
                    isLoading: false,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isGridView && !isRemoving
                ?  GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2/3),
              itemCount: inventory.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final item = inventory[index];
                final selectedQuantity = selectedItems[item.name] ?? 0;

                return InventoryCard(
                  item: item,
                  isRemoving: isRemoving,
                  selectedQuantity: selectedQuantity,
                  onSelectQuantity: (quantity) =>
                      _toggleItemSelection(item, quantity),
                  onRemove: () => setState(() {
                    if (item.quantity == selectedQuantity) {
                      inventory.remove(item);
                    } else {
                      item.quantity -= selectedQuantity;
                    }
                    selectedItems.remove(item.name);
                  }),
                  onSelectAll: () =>
                      _toggleItemSelection(item, item.quantity),
                  height: Get.height * .1,
                  width: Get.width * .19,
                  horizontalPadding: 10,
                  verticalPadding: 1,
                  // isGrid: true,
                );
              },
            )
                : ListView.builder(
                    itemCount: inventory.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final item = inventory[index];
                      final selectedQuantity = selectedItems[item.name] ?? 0;

                      return InventoryCard(
                        // isGrid: false,
                        item: item,
                        isRemoving: isRemoving,
                        selectedQuantity: selectedQuantity,
                        onSelectQuantity: (quantity) =>
                            _toggleItemSelection(item, quantity),
                        onRemove: () => setState(() {
                          if (item.quantity == selectedQuantity) {
                            inventory.remove(item);
                          } else {
                            item.quantity -= selectedQuantity;
                          }
                          selectedItems.remove(item.name);
                        }),
                        onSelectAll: () =>
                            _toggleItemSelection(item, item.quantity),
                        height: Get.height * .15,
                        width: Get.width * .25,
                        horizontalPadding: 15,
                        verticalPadding: 5,
                      );
                    },
                  ),
          ),
          if (isRemoving && selectedItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 5),
              child: CustomButton(
                tag: "",
                backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(.9),
                height: Get.height * .054,
                textHeight: 16,
                isLoading: false,
                onPressed: _removeSelectedItems,
                text: 'Confirm Remove',
              ),
            ),
        ],
      ),
    );
  }
}
