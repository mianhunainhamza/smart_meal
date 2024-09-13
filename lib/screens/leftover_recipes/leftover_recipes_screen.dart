import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/food.dart';
import '../../providers/cart_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../widgets/custom_floating_button.dart';
import '../recipes/components/food_card.dart';

class LeftoverRecipesScreen extends StatefulWidget {
  const LeftoverRecipesScreen({super.key});

  @override
  State<LeftoverRecipesScreen> createState() => LeftoverRecipesScreenState();
}

class LeftoverRecipesScreenState extends State<LeftoverRecipesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Food> _filteredFoods = [];

  @override
  void initState() {
    super.initState();
    // Initially show all matching recipes based on inventory
    _filterFoodsBasedOnInventory();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      floatingActionButton: cartProvider.ingredients.isNotEmpty || cartProvider.items.isNotEmpty
          ? CustomFloatingAction(cartProvider: cartProvider)
          : Container(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search Recipes:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter recipe name',
                labelStyle: TextStyle(color: Colors.black.withOpacity(.3)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                _filterFoodsBasedOnInventory();
              },
            ),
            const SizedBox(height: 25),
            const SizedBox(height: 40),
            Expanded(
              child: _filteredFoods.isEmpty
                  ? const Center(child: Text('No matching recipes found.'))
                  : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.76 / 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 30,
                ),
                itemCount: _filteredFoods.length,
                itemBuilder: (ctx, index) {
                  final food = _filteredFoods[index];
                  return FoodCard(
                    food: food,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterFoodsBasedOnInventory() {
    final inventoryProvider = Provider.of<InventoryProvider>(context, listen: false);

    final userInventoryIngredients = inventoryProvider.inventory.map((ingredient) => ingredient.name.toLowerCase().trim()).toList();

    setState(() {
      _filteredFoods = foods.where((food) {
        final recipeIngredients = food.ingredients.map((ingredient) => ingredient.name.toLowerCase().trim()).toList();

        print('User Inventory Ingredients: $userInventoryIngredients');
        print('Recipe Ingredients: $recipeIngredients');

        final matchesInventory = recipeIngredients.every((ingredient) => userInventoryIngredients.contains(ingredient));

        final matchesSearch = food.name.toLowerCase().contains(_searchController.text.toLowerCase());

        return matchesInventory && matchesSearch;
      }).toList();
    });
  }




}
