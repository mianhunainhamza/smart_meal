class Ingredient {
  String name;
  int quantity;
  String unit;
  String image;
  double price;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.image,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'image': image,
      'price': price,
    };
  }

  Ingredient withAdjustedQuantity(int multiplier) {
    return Ingredient(
      name: name,
      quantity: quantity * multiplier,
      price: price,
      unit: unit,
      image: image,
    );
  }
  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
        name: map['name'],
        quantity: map['quantity'],
        unit: map['unit'],
        image: map['image'],
        price: map['price']);
  }
}
