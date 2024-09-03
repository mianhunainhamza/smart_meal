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
}
