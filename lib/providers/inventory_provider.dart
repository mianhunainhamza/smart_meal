import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/inventory_item.dart';

class InventoryProvider extends ChangeNotifier {
  String selectedCategory = 'All'; // Default category

  List<String> categories = ['All', 'Fruits', 'Vegetables', 'Dairy']; // Predefined categories

  List<InventoryItem> inventory = [
    InventoryItem(
      name: 'Apple',
      image: 'assets/images/apple.png',
      dateAdded: '10-12-2024',
      expiryDate: '20-12-2024',
      quantity: 10,
      price: 1.50,
      details: 'Fresh and organic', category: 'Fruits',
    ),
    InventoryItem(
      name: 'Banana',
      image: 'assets/images/banana.png',
      dateAdded: '12-10-2024',
      expiryDate: '12-11-2024',
      quantity: 20,
      price: 1.20, category: 'Fruits',
    ),InventoryItem(
      name: 'Egg',
      image: 'assets/images/eggs.png',
      dateAdded: '12-10-2024',
      expiryDate: '12-11-2024',
      quantity: 20,
      price: 1.20, category: 'Dairy',
    ),InventoryItem(
      name: 'Ginger',
      image: 'assets/images/ginger.png',
      dateAdded: '12-10-2024',
      expiryDate: '12-11-2024',
      quantity: 30,
      price: 1.20, category: 'Vegetables',
    ),InventoryItem(
      name: 'Garlic',
      image: 'assets/images/garlic.png',
      dateAdded: '12-10-2024',
      expiryDate: '12-11-2024',
      quantity: 20,
      price: 1.20, category: 'Vegetables',
    ),
    InventoryItem(
      name: 'Orange',
      image: 'assets/images/orange.png',
      dateAdded: '10-11-2024',
      expiryDate: '20-11-2024',
      quantity: 15,
      price: 2.00, category: 'Fruits',
    ),
  ];

// Check if an item is available in the inventory and has enough quantity
  bool isItemAvailable(String itemName, int requiredQuantity) {
    final item = inventory.firstWhereOrNull(
          (item) => item.name.toLowerCase() == itemName.toLowerCase(),
    );

    return item != null && item.quantity >= requiredQuantity;
  }

  void removeSelectedItems(Map<String, int> selectedItems) {
    selectedItems.forEach((itemName, quantity) {
      final item = inventory.firstWhere(
            (item) => item.name == itemName,
        orElse: () => InventoryItem(
          name: '',
          image: '',
          dateAdded: '',
          expiryDate: '',
          quantity: 0,
          price: 0.0, category: '',
        ),
      );

      if (item.name.isNotEmpty) {
        if (item.quantity <= quantity) {
          inventory.remove(item);
        } else {
          item.quantity -= quantity;
        }
      }
    });
    notifyListeners();
  }
  void addItem(InventoryItem item) {
    inventory.add(item);
    notifyListeners();
  }

  void updateItem(InventoryItem oldItem, InventoryItem newItem) {
    final index = inventory.indexOf(oldItem);
    if (index != -1) {
      inventory[index] = newItem;
      notifyListeners();
    }
  }




  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  List<InventoryItem> get filteredInventory {
    if (selectedCategory == 'All') {
      return inventory;
    } else {
      return inventory.where((item) => item.category == selectedCategory).toList();
    }
  }


  // Add item to the cart (you'll need a cart mechanism)
  void addItemToCart(String itemName) {
    // Implement your cart logic here
    notifyListeners();
  }

  // Method to remove an item from the inventory
  void removeItem(InventoryItem item) {
    inventory.remove(item);
    notifyListeners();
  }

  // Method to remove an item by name (optional)
  void removeItemByName(String itemName) {
    inventory.removeWhere((item) => item.name == itemName);
    notifyListeners();
  }

  // Method to update the quantity of an item
  void updateItemQuantity(String itemName, int newQuantity) {
    final index = inventory.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      inventory[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  // Method to get the list of inventory items
  List<InventoryItem> getInventoryItems() {
    return inventory;
  }
}
