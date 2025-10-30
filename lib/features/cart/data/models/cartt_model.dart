class CartResponse {
  final bool? success;
  final int ?itemsCount;
  final List<CartItem> ?items;
  final double ?subtotal;
  final double ?shipping;
  final double ?discount;
  final double ?total;

  CartResponse({
    this.success,
    this.itemsCount,
    this.items,
    this.subtotal,
    this.shipping,
    this.discount,
    this.total,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      success: json['success'],
      itemsCount: json['items_count'],
      items: (json['items'] as List)
          .map((e) => CartItem.fromJson(e))
          .toList(),
      subtotal: double.parse(json['subtotal'].toString()),
      shipping: double.parse(json['shipping'].toString()),
      discount: double.parse(json['discount'].toString()),
      total: double.parse(json['total'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "items_count": itemsCount,
      "items": items?.map((e) => e.toJson()).toList(),
      "subtotal": subtotal,
      "shipping": shipping,
      "discount": discount,
      "total": total,
    };
  }
}

class CartItem {
  final int id;
  final int quantity;
  final String price;
  final Product product;
  final List<dynamic> selectedOptions; // can be modeled if needed
  final double totalPrice;

  CartItem({
    required this.id,
    required this.quantity,
    required this.price,
    required this.product,
    required this.selectedOptions,
    required this.totalPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'],
      price: json['price'],
      product: Product.fromJson(json['product']),
      selectedOptions: List<dynamic>.from(json['selected_options'] ?? []),
      totalPrice: double.parse(json['total_price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "quantity": quantity,
      "price": price,
      "product": product.toJson(),
      "selected_options": selectedOptions,
      "total_price": totalPrice,
    };
  }
}

class Product {
  final int id;
  final String name;
  final String slug;
  final String? image;
  final double? basePrice;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    this.image,
    this.basePrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      basePrice: json['base_price'] != null
          ? double.tryParse(json['base_price'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "image": image,
      "base_price": basePrice,
    };
  }
}