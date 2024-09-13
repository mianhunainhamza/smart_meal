import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/catalog.dart';
import '../models/food.dart';
import '../models/ingredient.dart';
import '../models/inventory_item.dart';

class InventoryProvider extends ChangeNotifier {
  String selectedCategory = 'All';

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
    ),InventoryItem(
      name: 'Bread',
      image: 'assets/images/white-bread.png',
      dateAdded: '10-12-2024',
      expiryDate: '20-12-2024',
      quantity: 4,
      price: 1.50,
      details: 'Fresh and organic', category: 'Dairy',
    ),InventoryItem(
      name: 'Milk',
      image: 'assets/images/milks.png',
      dateAdded: '10-12-2024',
      expiryDate: '20-12-2024',
      quantity: 100,
      price: 1.50,
      details: 'Fresh and organic', category: 'Dairy',
    ),InventoryItem(
      name: 'Sugar',
      image: 'assets/images/sugar.png',
      dateAdded: '10-12-2024',
      expiryDate: '20-12-2024',
      quantity: 20,
      price: 1.50,
      details: 'Fresh and organic', category: 'Dairy',
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

  void updateInventoryFromItem(Item item) {
    final existingItem = inventory.firstWhereOrNull((i) => i.name == item.name);

    final todayDate = DateTime.now();
    final expiryDate = todayDate.add(const Duration(days: 10));
    final formattedTodayDate = "${todayDate.day}-${todayDate.month}-${todayDate.year}";
    final formattedExpiryDate = "${expiryDate.day}-${expiryDate.month}-${expiryDate.year}";

    if (existingItem != null) {
      final newQuantity = existingItem.quantity + item.quantity;
      final updatedItem = existingItem.copyWith(quantity: newQuantity);
      updateItem(existingItem, updatedItem);
    } else {
      final newItem = InventoryItem(
        name: item.name,
        image: item.image,
        dateAdded: formattedTodayDate,
        expiryDate: formattedExpiryDate,
        quantity: item.quantity,
        price: item.prices,
        category: 'Dairy',
      );
      addItem(newItem);
    }
  }

  void updateInventoryFromIngredient(Ingredient ingredient) {
    final existingItem = inventory.firstWhereOrNull((i) => i.name == ingredient.name);

    final todayDate = DateTime.now();
    final expiryDate = todayDate.add(const Duration(days: 10));
    final formattedTodayDate = "${todayDate.day}-${todayDate.month}-${todayDate.year}";
    final formattedExpiryDate = "${expiryDate.day}-${expiryDate.month}-${expiryDate.year}";

    if (existingItem != null) {
      final newQuantity = existingItem.quantity! + ingredient.quantity;
      final updatedItem = existingItem.copyWith(quantity: newQuantity);
      updateItem(existingItem, updatedItem);
    } else {
      final newItem = InventoryItem(
        name: ingredient.name,
        image: ingredient.image,
        dateAdded: formattedTodayDate,
        expiryDate: formattedExpiryDate,
        quantity: ingredient.quantity,
        price: ingredient.price,
        category: 'Dairy',
      );
      addItem(newItem);
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

  void toggleLikeStatus(Food foodItem) {
    final index = foods.indexWhere((food) => food.name == foodItem.name);

    // Check if the food item exists
    if (index != -1) {
      // Toggle the 'isLiked' status
      print('liked');
      foods[index].isLiked = !foods[index].isLiked;
    } else {
      print('Food item not found.');
    }
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
