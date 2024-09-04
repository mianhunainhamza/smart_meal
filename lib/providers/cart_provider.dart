import 'package:flutter/material.dart';
import 'package:smart_meal/models/ingredient.dart';
import '../models/catalog.dart';
import '../models/food.dart';

class CartProvider with ChangeNotifier {
  final List<Item> _items = [];
  late double price = 2;
  final List<Ingredient> _ingredientItems = [];

  List<Item> get items => _items;
  List<Ingredient> get ingredients => _ingredientItems;

  num get totalPrice => _items.fold(0, (sum, item) => sum + item.prices);
  num get totalIngredientPrice => price;

  void addPrice() {
    price += 2;
    notifyListeners();
  }

  void removePrice() {
    price -= 2;
    notifyListeners();
  }

  void addItem(Item item) {
    _items.add(item);
    print('Item added: ${item.name}');
    notifyListeners();
  }

  void addIngredientItem(Ingredient ingredient) {
    _ingredientItems.add(ingredient);
    addPrice();
    print('Ingredient added: ${ingredient.name}');
    notifyListeners();
  }

  void removeItem(Item item) {
    _items.remove(item);
    print('Item removed: ${item.name}');
    notifyListeners();
  }

  void removeIngredientItem(Ingredient ingredient) {
    _ingredientItems.remove(ingredient);
    removePrice();
    print('Ingredient removed: ${ingredient.name}');
    notifyListeners();
  }

  // Update the quantity of an item
  void updateItemQuantity(Item item, int newQuantity) {
    final index = _items.indexOf(item);
    if (index != -1) {
      final oldQuantity = _items[index].quantity;
      _items[index].quantity = newQuantity;
      // Adjust price based on new quantity
      final priceChange = (newQuantity - oldQuantity) * item.prices;
      if (priceChange > 0) {
        addPrice();
      } else {
        removePrice();
      }
      notifyListeners();
    }
  }

  // Update the quantity of an ingredient
  void updateIngredientQuantity(Ingredient ingredient, int newQuantity) {
    final index = _ingredientItems.indexOf(ingredient);
    if (index != -1) {
      final oldQuantity = _ingredientItems[index].quantity;
      _ingredientItems[index].quantity = newQuantity;
      if (newQuantity > 0) {
        addPrice();
      } else {
        removePrice();
      }
      notifyListeners();
    }
  }
}
