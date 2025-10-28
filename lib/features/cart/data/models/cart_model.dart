class CartModel {
  final int id;
  final String name;
  final String? description;
  final String imageUrl;
  final double price;
  final int? quantity;
  final String size;
  final String color;

  CartModel({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
    required this.price,
    this.quantity,
    required this.size,
    required this.color,
  });
}