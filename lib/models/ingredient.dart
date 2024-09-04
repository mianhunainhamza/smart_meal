class Ingredient {
   String name;
   int quantity;
   String unit;
   String image;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'image': image,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'],
      quantity: map['quantity'],
      unit: map['unit'],
      image: map['image'],
    );
  }
}
