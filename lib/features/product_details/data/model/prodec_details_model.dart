class ProductDetailsModel {
  final bool success;
  final ProductData? data;
  final Pricing? pricing;

  ProductDetailsModel({
    required this.success,
    this.data,
    this.pricing,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      success: json['success'] ?? false,
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
      pricing:
      json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data?.toJson(),
    'pricing': pricing?.toJson(),
  };
}

class ProductData {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final double? basePrice;
  final double? minPrice;
  final double? maxPrice;
  final bool inStock;
  final bool isActive;
  final int? views;
  final Category? category;
  final List<Option> options;
  final List<Variant> variants;

  ProductData({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.basePrice,
    this.minPrice,
    this.maxPrice,
    required this.inStock,
    required this.isActive,
    this.views,
    this.category,
    required this.options,
    required this.variants,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'],
      basePrice: (json['base_price'] != null)
          ? double.tryParse(json['base_price'].toString())
          : null,
      minPrice: (json['min_price'] != null)
          ? double.tryParse(json['min_price'].toString())
          : null,
      maxPrice: (json['max_price'] != null)
          ? double.tryParse(json['max_price'].toString())
          : null,
      inStock: json['in_stock'] ?? false,
      isActive: json['is_active'] ?? false,
      views: json['views'],
      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
      options: (json['options'] as List<dynamic>? ?? [])
          .map((e) => Option.fromJson(e))
          .toList(),
      variants: (json['variants'] as List<dynamic>? ?? [])
          .map((e) => Variant.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'description': description,
    'base_price': basePrice,
    'min_price': minPrice,
    'max_price': maxPrice,
    'in_stock': inStock,
    'is_active': isActive,
    'views': views,
    'category': category?.toJson(),
    'options': options.map((e) => e.toJson()).toList(),
    'variants': variants.map((e) => e.toJson()).toList(),
  };
}

class Category {
  final int id;
  final String name;
  final String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    name: json['name'] ?? '',
    slug: json['slug'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
  };
}

class Option {
  final int id;
  final String name;
  final int requiredOption;
  final List<OptionValue> values;

  Option({
    required this.id,
    required this.name,
    required this.requiredOption,
    required this.values,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json['id'],
    name: json['name'] ?? '',
    requiredOption: json['required'] ?? 0,
    values: (json['values'] as List<dynamic>? ?? [])
        .map((e) => OptionValue.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'required': requiredOption,
    'values': values.map((e) => e.toJson()).toList(),
  };
}

class OptionValue {
  final int id;
  final String value;
  final String priceModifier;

  OptionValue({
    required this.id,
    required this.value,
    required this.priceModifier,
  });

  factory OptionValue.fromJson(Map<String, dynamic> json) => OptionValue(
    id: json['id'],
    value: json['value'] ?? '',
    priceModifier: json['price_modifier'] ?? '0.00',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'value': value,
    'price_modifier': priceModifier,
  };
}

class Variant {
  final int id;
  final String sku;
  final String price;
  final int stock;
  final String stockStatus;
  final String image;
  final List<String> options;

  Variant({
    required this.id,
    required this.sku,
    required this.price,
    required this.stock,
    required this.stockStatus,
    required this.image,
    required this.options,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json['id'],
    sku: json['sku'] ?? '',
    price: json['price'] ?? '0.0',
    stock: json['stock'] ?? 0,
    stockStatus: json['stock_status'] ?? '',
    image: json['image'] ?? '',
    options:
    (json['options'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'sku': sku,
    'price': price,
    'stock': stock,
    'stock_status': stockStatus,
    'image': image,
    'options': options,
  };
}

class Pricing {
  final double originalPrice;
  final double discountedPrice;
  final double discountAmount;
  final double discountPercentage;
  final bool hasOffer;
  final bool hasVariants;
  final double maxDiscountedPrice;

  Pricing({
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountAmount,
    required this.discountPercentage,
    required this.hasOffer,
    required this.hasVariants,
    required this.maxDiscountedPrice,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
    originalPrice: (json['original_price'] ?? 0).toDouble(),
    discountedPrice: (json['discounted_price'] ?? 0).toDouble(),
    discountAmount: (json['discount_amount'] ?? 0).toDouble(),
    discountPercentage: (json['discount_percentage'] ?? 0).toDouble(),
    hasOffer: json['has_offer'] ?? false,
    hasVariants: json['has_variants'] ?? false,
    maxDiscountedPrice: (json['max_discounted_price'] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'original_price': originalPrice,
    'discounted_price': discountedPrice,
    'discount_amount': discountAmount,
    'discount_percentage': discountPercentage,
    'has_offer': hasOffer,
    'has_variants': hasVariants,
    'max_discounted_price': maxDiscountedPrice,
  };
}
