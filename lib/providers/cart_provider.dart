import 'package:flutter/material.dart';
import 'package:smart_meal/models/ingredient.dart';
import '../models/catalog.dart';

class CartProvider with ChangeNotifier {
  final List<Item> _items = [];
  final List<Ingredient> _ingredientItems = [];

  List<Item> get items => _items;

  List<Ingredient> get ingredients => _ingredientItems;

  num get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.prices * (item.quantity ?? 1)));

  num get totalIngredientPrice =>
      _ingredientItems.fold(0, (sum, ingredient) {
        final adjustedPrice = _calculateAdjustedPrice(ingredient);
        return sum + adjustedPrice;
      });

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  // Define the method to update the ingredient
  void updateIngredientItem(int index, int newQuantity) {
    if (index >= 0 && index < ingredients.length) {
      ingredients[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void addIngredientItem(Ingredient ingredient) {
    if (ingredient.quantity <= 0) {
      print('Error: Ingredient quantity must be greater than zero.');
      return;
    }

    _ingredientItems.add(ingredient);
    print('Ingredient added: ${ingredient.name}');
    notifyListeners();
  }

  // Remove item from the list
  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeIngredientItem(Ingredient ingredient) {
    _ingredientItems.remove(ingredient);
    notifyListeners();
  }

  void updateItemQuantity(Item item, int newQuantity) {
    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void updateIngredientQuantity(Ingredient ingredient, int newQuantity) {
    final index = _ingredientItems.indexOf(ingredient);
    if (index != -1) {
      _ingredientItems[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  num _calculateAdjustedPrice(Ingredient ingredient) {
    final pricePerUnit = ingredient.price;
    final quantity = ingredient.quantity ?? 1;
    final unit = ingredient.unit;

    final conversionFactors = {
      'kg': 1000,
      'g': 1,
      'ml': 1,
      'L': 1000,
    };

    if (conversionFactors.containsKey(unit)) {
      if (unit == 'g' || unit == 'ml') {
        final adjustedPrice = (pricePerUnit / 1000) * quantity;
        return adjustedPrice;
      } else if (unit == 'kg' || unit == 'L') {
        return pricePerUnit * quantity;
      }
    }
    return pricePerUnit * quantity;
  }
}
