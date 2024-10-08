import 'dart:convert';

class CatalogModel {
  static List<Item> items = [];

  Item getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse:null);

  Item getByPosition(int pos) => items[pos];
}

class Item {
  int id;
  String name;
  String desc;
  double prices;
  int quantity;
  String color;
  String image;
  String unit; // Added unit property

  Item(
      this.quantity,
      this.id,
      this.name,
      this.desc,
      this.prices,
      this.color,
      this.image,
      this.unit, // Added unit parameter
      );

  Item copyWith({
    int? id,
    int? quantity,
    String? name,
    String? desc,
    double? prices,
    String? color,
    String? image,
    String? unit, // Added unit parameter
  }) {
    return Item(
      quantity ?? this.quantity,
      id ?? this.id,
      name ?? this.name,
      desc ?? this.desc,
      prices ?? this.prices,
      color ?? this.color,
      image ?? this.image,
      unit ?? this.unit, // Added unit parameter
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'desc': desc,
      'quantity': quantity,
      'prices': prices,
      'color': color,
      'image': image,
      'unit': unit, // Added unit to map
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      map['quantity'] as int,
      map['id'] as int,
      map['name'] as String,
      map['desc'] as String,
      map['prices'] as double,
      map['color'] as String,
      map['image'] as String,
      map['unit'] as String, // Added unit from map
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, name: $name, desc: $desc, prices: $prices, color: $color, image: $image, unit: $unit)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.desc == desc &&
        other.prices == prices &&
        other.color == color &&
        other.image == image &&
        other.unit == unit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    name.hashCode ^
    desc.hashCode ^
    prices.hashCode ^
    color.hashCode ^
    image.hashCode ^
    unit.hashCode; // Include unit in hashCode
  }
}
