import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:smart_meal/widgets/custom_button.dart';
import '../../models/inventory_item.dart';
import '../../providers/cart_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../widgets/custom_floating_button.dart';
import 'components/add_item_screen.dart';
import 'components/inventory_card.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  InventoryScreenState createState() => InventoryScreenState();
}

class InventoryScreenState extends State<InventoryScreen> {
  bool isRemoving = false;
  bool isGridView = true;
  Map<String, int> selectedItems = {};

  void _addItem(String method) {
    if (method == 'Manual Input') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddItemScreen()),
      );
    } else {
      print('No method implemented');
    }
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
    final provider = Provider.of<InventoryProvider>(context, listen: false);
    provider.removeSelectedItems(selectedItems);
    setState(() {
      selectedItems.clear();
      isRemoving = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
     floatingActionButton:cartProvider.ingredients.isNotEmpty || cartProvider.items.isNotEmpty
        ? CustomFloatingAction(cartProvider: cartProvider)
        : Container(),
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
      body: Consumer<InventoryProvider>(
        builder: (context, provider, child) {
          final inventory = provider.filteredInventory;

          return Column(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.9),
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
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        backgroundColor: isRemoving
                            ? Colors.red.withOpacity(.7)
                            : Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.9),
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
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.categories.length,
                  itemBuilder: (context, index) {
                    final category = provider.categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: ChoiceChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            color: provider.selectedCategory == category ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        selected: provider.selectedCategory == category,
                        onSelected: (selected) {
                          provider.setCategory(category);
                        },
                        selectedColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: provider.selectedCategory == category ? Theme.of(context).colorScheme.primary : Colors.grey.withOpacity(.2),
                          ),
                        ),
                        elevation: 3,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      )

                    );
                  },
                ),
              ),
              Expanded(
                child: isGridView && !isRemoving
                    ? GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 3),
                  itemCount: inventory.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final item = inventory[index];
                    final selectedQuantity =
                        selectedItems[item.name] ?? 0;

                    return InventoryCard(
                      item: item,
                      isRemoving: isRemoving,
                      selectedQuantity: selectedQuantity,
                      onSelectQuantity: (quantity) =>
                          _toggleItemSelection(item, quantity),
                      onRemove: () => setState(() {
                        if (item.quantity == selectedQuantity) {
                          provider.removeItem(item);
                        } else {
                          item.quantity -= selectedQuantity;
                          provider.updateItem(item, item);
                        }
                        selectedItems.remove(item.name);
                      }),
                      onSelectAll: () =>
                          _toggleItemSelection(item, item.quantity),
                      height: Get.height * .09,
                      width: Get.width * .19,
                      horizontalPadding: 10,
                      verticalPadding: 1,
                    );
                  },
                )
                    : ListView.builder(
                  itemCount: inventory.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final item = inventory[index];
                    final selectedQuantity =
                        selectedItems[item.name] ?? 0;

                    return InventoryCard(
                      item: item,
                      isRemoving: isRemoving,
                      selectedQuantity: selectedQuantity,
                      onSelectQuantity: (quantity) =>
                          _toggleItemSelection(item, quantity),
                      onRemove: () => setState(() {
                        if (item.quantity == selectedQuantity) {
                          provider.removeItem(item);
                        } else {
                          item.quantity -= selectedQuantity;
                          provider.updateItem(item, item);
                        }
                        selectedItems.remove(item.name);
                      }),
                      onSelectAll: () =>
                          _toggleItemSelection(item, item.quantity),
                      height: Get.height * .1,
                      width: Get.width * .23,
                      horizontalPadding: 15,
                      verticalPadding: 5,
                    );
                  },
                ),
              ),
              if (isRemoving && selectedItems.isNotEmpty)
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                  child: CustomButton(
                    tag: "",
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(.9),
                    height: Get.height * .054,
                    textHeight: 16,
                    isLoading: false,
                    onPressed: _removeSelectedItems,
                    text: 'Confirm Remove',
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}