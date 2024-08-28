import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class RecipeFinderScreen extends StatefulWidget {
  const RecipeFinderScreen({super.key});

  @override
  RecipeFinderScreenState createState() => RecipeFinderScreenState();
}

class RecipeFinderScreenState extends State<RecipeFinderScreen> {
  final TextEditingController _ingredientController = TextEditingController();
  final List<String> _selectedIngredients = [];
  List<Recipe> _filteredRecipes = [];

  final List<Recipe> _dummyRecipes = [
    Recipe(
      title: "Ramen Noodles",
      imageAsset: "assets/images/ramen-noodles.jpg",
      ingredients: ["Noodles 1x Pack", "Broth", "Egg 4x", "Scallions"],
      instructions:
      "Cook noodles, prepare broth, and serve with boiled egg and scallions.",
    ),
    Recipe(
      title: "Butter Chicken",
      imageAsset: "assets/images/butter-chicken.jpg",
      ingredients: ["Chicken 1.5kg", "Butter 1x", "Tomato Puree 200g", "Spices 3x"],
      instructions:
      "Cook chicken in butter, add tomato puree, and simmer with spices.",
    ),
    Recipe(
      title: "Dumplings",
      imageAsset: "assets/images/dumplings.jpg",
      ingredients: ["Flour 1kg", "Pork 1kg", "Ginger 4x ", "Garlic 3x"],
      instructions:
      "Prepare dough, fill with pork and spices, and steam until cooked.",
    ),
    Recipe(
      title: "Beef Steak",
      imageAsset: "assets/images/beaf-steak.jpg",
      ingredients: ["Beef 500g", "Salt 2 tbs", "Pepper 4 tbs", "Garlic Butter 1x"],
      instructions:
      "Season beef, sear in hot pan, and serve with garlic butter.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filteredRecipes = List.from(_dummyRecipes); // Initially display all recipes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe Finder',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
            // Ingredient Input Field
            TextField(
              controller: _ingredientController,
              decoration: InputDecoration(
                labelText: 'Enter an ingredient',
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
                      _filteredRecipes = List.from(_dummyRecipes);
                    } else {
                      _filterRecipes();
                    }
                  });
                },
              ))
                  .toList(),
            ),
            // Find Recipes Button
            const SizedBox(height: 25,),
            Center(
              child: CustomButton(
                text: 'Find Recipe',
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.9),
                onPressed: () {
                  _filterRecipes();
                },
                isLoading: false,
                tag: '',
              ),
            ),
            const SizedBox(height: 20),
            // Recipe Results Display
            Expanded(
              child: _filteredRecipes.isEmpty
                  ? const Center(child: Text('No recipes found.'))
                  : ListView.builder(
                itemCount: _filteredRecipes.length,
                itemBuilder: (ctx, index) {
                  final recipe = _filteredRecipes[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: Hero(
                        tag: recipe.title,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            recipe.imageAsset,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                      title: Text(
                        recipe.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Text(
                        'Ingredients: ${recipe.ingredients.join(', ')}',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(recipe: recipe),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterRecipes() {
    setState(() {
      _filteredRecipes = _dummyRecipes.where((recipe) {
        return _selectedIngredients.every((ingredient) =>
            recipe.ingredients.any((recipeIngredient) =>
                recipeIngredient.toLowerCase().contains(ingredient.toLowerCase())));
      }).toList();
    });
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image with Hero Animation
            Hero(
              tag: recipe.title,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  recipe.imageAsset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Recipe Title
            Text(
              recipe.title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            // Ingredients Section
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: recipe.ingredients.map(
                    (ingredient) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      const Text('-'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          ingredient,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ).toList(),
            ),
            const SizedBox(height: 20),
            // Instructions Section
            const Text(
              'Instructions',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              color: Theme.of(context).colorScheme.surface,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  recipe.instructions,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Recipe {
  final String title;
  final String imageAsset;
  final List<String> ingredients;
  final String instructions;

  Recipe({
    required this.title,
    required this.imageAsset,
    required this.ingredients,
    required this.instructions,
  });
}
