import 'ingredient.dart';

class Food {
  String name;
  String image;
  List<Ingredient> ingredients;
  String instructions;
  int cal;
  int time;
  double rate;
  int reviews;
  bool isLiked;

  Food({
    required this.name,
    required this.image,
    required this.ingredients,
    required this.instructions,
    required this.cal,
    required this.time,
    required this.rate,
    required this.reviews,
    required this.isLiked,
  });
}

final List<Food> foods = [
  Food(
    name: "Spicy Ramen Noodles",
    image: "assets/images/ramen-noodles.jpg",
    ingredients: [
      Ingredient(
        name: 'Noodles',
        quantity: 1,
        price: 5.50,
        // 2.50 + 3
        unit: 'x',
        image: 'assets/images/noodles.png',
      ),
      Ingredient(
        name: 'Broth',
        quantity: 500,
        price: 4.20,
        // 1.20 + 3
        unit: 'ml',
        image: 'assets/images/broth.png',
      ),
      Ingredient(
        name: 'Egg',
        quantity: 1,
        price: 3.30,
        // 0.30 + 3
        unit: 'x',
        image: 'assets/images/eggs.png',
      ),
      Ingredient(
        name: 'Scallions',
        quantity: 50,
        price: 3.70,
        // 0.70 + 3
        unit: 'g',
        image: 'assets/images/scallion.png',
      ),
    ],
    instructions:
        "Cook noodles, prepare broth, and serve with boiled egg and scallions.",
    cal: 120,
    time: 15,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
  ),
  Food(
    name: "Beef Steak",
    image: "assets/images/beaf-steak.jpg",
    ingredients: [
      Ingredient(
        name: 'Beef',
        quantity: 1,
        price: 4.00,
        // 1.00 + 3
        unit: 'kg',
        image: 'assets/images/beef.png',
      ),
      Ingredient(
        name: 'Salt',
        quantity: 5,
        price: 3.05,
        // 0.05 + 3
        unit: 'g',
        image: 'assets/images/salt-shaker.png',
      ),
      Ingredient(
        name: 'Pepper',
        quantity: 2,
        price: 3.10,
        // 0.10 + 3
        unit: 'g',
        image: 'assets/images/red-chili-pepper.png',
      ),
      Ingredient(
        name: 'Garlic Butter',
        quantity: 50,
        price: 4.50,
        // 1.50 + 3
        unit: 'g',
        image: 'assets/images/butters.png',
      ),
    ],
    instructions: "Season beef, sear in hot pan, and serve with garlic butter.",
    cal: 140,
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: true,
  ),
  Food(
    name: "Butter Chicken",
    image: "assets/images/butter-chicken.jpg",
    ingredients: [
      Ingredient(
        name: 'Chicken',
        quantity: 300,
        price: 6.00,
        // 3.00 + 3
        unit: 'g',
        image: 'assets/images/chicken-leg.png',
      ),
      Ingredient(
        name: 'Butter',
        quantity: 100,
        price: 5.00,
        // 2.00 + 3
        unit: 'g',
        image: 'assets/images/butters.png',
      ),
      Ingredient(
        name: 'Tomato Puree',
        quantity: 200,
        price: 4.50,
        // 1.50 + 3
        unit: 'ml',
        image: 'assets/images/tomato.png',
      ),
      Ingredient(
        name: 'Spices',
        quantity: 20,
        price: 3.80,
        // 0.80 + 3
        unit: 'g',
        image: 'assets/images/red-chili-pepper.png',
      ),
    ],
    instructions:
        "Cook chicken in butter, add tomato puree, and simmer with spices.",
    cal: 130,
    time: 18,
    rate: 4.2,
    reviews: 10,
    isLiked: false,
  ),
  Food(
    name: "French Toast",
    image: "assets/images/french-toast.jpg",
    ingredients: [
      Ingredient(
        name: 'Bread',
        quantity: 4,
        price: 3.80,
        // 0.80 + 3
        unit: 'slices',
        image: 'assets/images/white-bread.png',
      ),
      Ingredient(
        name: 'Egg',
        quantity: 2,
        price: 3.60,
        // 0.60 + 3
        unit: 'x',
        image: 'assets/images/eggs.png',
      ),
      Ingredient(
        name: 'Milk',
        quantity: 100,
        price: 3.50,
        // 0.50 + 3
        unit: 'ml',
        image: 'assets/images/milks.png',
      ),
      Ingredient(
        name: 'Sugar',
        quantity: 20,
        price: 3.10,
        // 0.10 + 3
        unit: 'g',
        image: 'assets/images/sugar.png',
      ),
    ],
    instructions:
        "Dip bread in egg mixture, cook on skillet, and serve with syrup.",
    cal: 110,
    time: 16,
    rate: 4.6,
    reviews: 90,
    isLiked: true,
  ),
  Food(
    name: "Dumplings",
    image: "assets/images/dumplings.jpg",
    ingredients: [
      Ingredient(
        name: 'Flour',
        quantity: 200,
        price: 3.60,
        // 0.60 + 3
        unit: 'g',
        image: 'assets/images/flour.png',
      ),
      Ingredient(
        name: 'Chicken',
        quantity: 150,
        price: 5.00,
        // 2.00 + 3
        unit: 'g',
        image: 'assets/images/chicken-leg.png',
      ),
      Ingredient(
        name: 'Ginger',
        quantity: 10,
        price: 3.30,
        // 0.30 + 3
        unit: 'g',
        image: 'assets/images/ginger.png',
      ),
      Ingredient(
        name: 'Garlic',
        quantity: 5,
        price: 3.20,
        // 0.20 + 3
        unit: 'g',
        image: 'assets/images/garlic.png',
      ),
    ],
    instructions:
        "Prepare dough, fill with pork and spices, and steam until cooked.",
    cal: 150,
    time: 30,
    rate: 4.0,
    reviews: 76,
    isLiked: false,
  ),
  Food(
    name: "Mexican Pizza",
    image: "assets/images/mexican-pizza.jpg",
    ingredients: [
      Ingredient(
        name: 'Pizza Dough',
        quantity: 1,
        price: 5.50,
        // 2.50 + 3
        unit: 'x',
        image: 'assets/images/pizza.png',
      ),
      Ingredient(
        name: 'Ground Beef',
        quantity: 200,
        price: 7.00,
        // 4.00 + 3
        unit: 'g',
        image: 'assets/images/beef.png',
      ),
      Ingredient(
        name: 'Cheese',
        quantity: 100,
        price: 4.50,
        // 1.50 + 3
        unit: 'g',
        image: 'assets/images/cheese.png',
      ),
      Ingredient(
        name: 'Salsa',
        quantity: 50,
        price: 4.00,
        // 1.00 + 3
        unit: 'ml',
        image: 'assets/images/salsa.png',
      ),
    ],
    instructions: "Spread salsa on dough, top with beef and cheese, and bake.",
    cal: 140,
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
  ),
];
