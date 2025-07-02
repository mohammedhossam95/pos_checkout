import 'dart:convert';

class Item {
  final String id;
  final String name;
  final double price;

  const Item({required this.id, required this.name, required this.price});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }

  static List<Item> fromJsonList(String jsonString) {
    final List<dynamic> list = json.decode(jsonString);
    return list.map((e) => Item.fromJson(e)).toList();
  }
}
