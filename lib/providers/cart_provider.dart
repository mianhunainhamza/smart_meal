import 'package:flutter/material.dart';
import 'package:smart_meal/models/ingredient.dart';
import '../models/catalog.dart';
import '../models/food.dart';

class CartProvider with ChangeNotifier {
  final List<Item> _items = [];
  late double price = 0;
  final List<Ingredient> _ingredientItems = [];

  List<Item> get items => _items;
  List<Ingredient> get recipeItems => _ingredientItems;

  num get totalPrice => _items.fold(0, (sum, item) => sum + item.prices);
  num get totalIngredientPrice => price;


  void addPrice()
  {
    price = price+2;
  }

  void removePrice()
  {
    price = price-2;
  }

  void addItem(Item item) {
    _items.add(item);
    print('Item added: ${item.name}');
    notifyListeners();
  }
  void addIngredientItem(Ingredient ingredient) {
    _ingredientItems.add(ingredient);
    addPrice();
    print('Item added: ${ingredient.name}');
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
    print('Item removed: ${ingredient.name}');
    notifyListeners();
  }

}
