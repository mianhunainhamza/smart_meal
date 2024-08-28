
class InventoryItem {
  final String name;
  final String image;
  final String dateAdded;
  final String expiryDate;
  int quantity;
  final double price;
  final String? details;

  InventoryItem({
    required this.name,
    required this.image,
    required this.dateAdded,
    required this.expiryDate,
    required this.quantity,
    required this.price,
    this.details,
  });
}