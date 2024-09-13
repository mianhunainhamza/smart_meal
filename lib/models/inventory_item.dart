class InventoryItem {
  String name;
  String image;
  String dateAdded;
  String expiryDate;
  int quantity;
  double price;
  String? details;
  String category;

  InventoryItem({
    required this.name,
    required this.image,
    required this.dateAdded,
    required this.expiryDate,
    required this.quantity,
    required this.price,
    this.details,
    required this.category,
  });

  InventoryItem copyWith({
    String? name,
    String? image,
    String? dateAdded,
    String? expiryDate,
    int? quantity,
    double? price,
    String? details,
    String? category,
  }) {
    return InventoryItem(
      name: name ?? this.name,
      image: image ?? this.image,
      dateAdded: dateAdded ?? this.dateAdded,
      expiryDate: expiryDate ?? this.expiryDate,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      details: details ?? this.details,
      category: category ?? this.category,
    );
  }
}
