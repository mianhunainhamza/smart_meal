import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_meal/widgets/custom_button.dart';
import '../../models/food.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/custom_floating_button.dart';
import 'components/food_card.dart';
import 'components/quick_screen_appbar.dart';

class QuickFoodsScreen extends StatefulWidget {
  const QuickFoodsScreen({super.key});

  @override
  State<QuickFoodsScreen> createState() => _QuickFoodsScreenState();
}

class _QuickFoodsScreenState extends State<QuickFoodsScreen> {
  final TextEditingController _ingredientController = TextEditingController();
  final List<String> _selectedIngredients = [];
  List<Food> _filteredFoods = [];

  @override
  void initState() {
    super.initState();
    _filteredFoods = List.from(foods);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      floatingActionButton:cartProvider.ingredients.isNotEmpty || cartProvider.items.isNotEmpty
          ? CustomFloatingAction(cartProvider: cartProvider)
          : Container(),
      appBar: AppBar(
        title: Text(
          'Quick Foods Finder',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
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
              'Enter Ingredients:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ingredientController,
              decoration: InputDecoration(
                labelText: 'Enter an ingredient',
                labelStyle: TextStyle(color: Colors.black.withOpacity(.3)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty && !_selectedIngredients.contains(value)) {
                  setState(() {
                    _selectedIngredients.add(value);
                    _ingredientController.clear();
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: _selectedIngredients
                  .map((ingredient) => Chip(
                label: Text(ingredient),
                backgroundColor: Colors.green.shade100,
                deleteIconColor: Colors.green,
                onDeleted: () {
                  setState(() {
                    _selectedIngredients.remove(ingredient);
                    if (_selectedIngredients.isEmpty) {
                      _filteredFoods = List.from(foods);
                    } else {
                      _filterFoods();
                    }
                  });
                },
              ))
                  .toList(),
            ),
            const SizedBox(height: 25),
            Center(
              child: CustomButton(
                onPressed: _filterFoods,
                text: 'Find Foods',
                isLoading: false,
                tag: '',
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: _filteredFoods.isEmpty
                  ? const Center(child: Text('No foods found.'))
                  : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.76/3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 30,
                ),
                itemCount: _filteredFoods.length,
                itemBuilder: (ctx, index) {
                  final food = _filteredFoods[index];
                  return FoodCard(
                    food: food,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterFoods() {
    setState(() {
      _filteredFoods = foods.where((food) {
        return _selectedIngredients.every((ingredient) {
          final lowerCaseIngredient = ingredient.toLowerCase();
          return food.ingredients.any((foodIngredient) {
            final ingredientName = foodIngredient.name.toLowerCase(); // Updated to use the Ingredient model's property
            return ingredientName.contains(lowerCaseIngredient);
          });
        });
      }).toList();
    });
  }
}
