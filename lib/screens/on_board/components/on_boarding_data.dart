class OnBoarding {
  String title;
  String description;
  String image;

  OnBoarding({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnBoarding> onBoardinglist = [
  OnBoarding(
    title: 'Tasty Meal Planning',
    image: 'assets/lottie/food3.json',
    description:
    'Plan and organize your meals with ease. Discover recipes, create shopping lists, and track your culinary adventures.',
  ),
  OnBoarding(
    title: "Delicious Recipes",
    image: 'assets/lottie/food.json',
    description:
    'Explore a variety of mouth-watering recipes to suit your taste. Find new dishes, save your favorites, and get cooking!',
  ),
  OnBoarding(
    title: "Smart Recipe Recommendations",
    image: 'assets/lottie/food2.json',
    description:
    'Receive personalized recipe suggestions based on your preferences and dietary needs. Explore new dishes with ease.',
  ),
];