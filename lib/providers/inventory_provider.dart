import 'package:flutter/cupertino.dart';
import '../models/inventory_item.dart';

class InventoryProvider extends ChangeNotifier {
  List<InventoryItem> inventory = [
    InventoryItem(
      name: 'Apple',
      image: 'assets/images/apple.png',
      dateAdded: '10-12-2024',
      expiryDate: '20-12-2024',
      quantity: 10,
      price: 1.50,
      details: 'Fresh and organic',
    ),
    InventoryItem(
      name: 'Banana',
      image: 'assets/images/banana.png',
      dateAdded: '12-10-2024',
      expiryDate: '12-11-2024',
      quantity: 20,
      price: 1.20,
    ),
    InventoryItem(
      name: 'Orange',
      image: 'assets/images/orange.png',
      dateAdded: '10-11-2024',
      expiryDate: '20-11-2024',
      quantity: 15,
      price: 2.00,
    ),
  ];

  // Check if an item is available in the inventory
  bool isItemAvailable(String itemName) {
    return inventory.any((item) => item.name.toLowerCase() == itemName.toLowerCase());
  }

  // Add item to the cart (you'll need a cart mechanism)
  void addItemToCart(String itemName) {
    // Implement your cart logic here
    notifyListeners();
  }

  // Method to add an item to the inventory
  void addItem(InventoryItem item) {
    inventory.add(item);
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
