import 'dart:convert';
import 'package:khouyot/core/models/image_product_model.dart';
import 'package:khouyot/core/models/product_model.dart';

class WishListModel {
  List<DataWish>? data;

  WishListModel({this.data});

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    return WishListModel(
      data: json['data'] != null
          ? List<DataWish>.from(json['data'].map((x) => DataWish.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class DataWish {
  int? id;
  String? uuid;
  String? name;
  String? slug;
  String? description;
  String? price;
  String? discountPrice; // Changed from Null to String?
  int? stock;
  int? categoryId;
  List<String>? images;
  List<ImageModel>? imageModels;
  bool? isActive;
  dynamic image; // Changed from Null to dynamic
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt; // Changed from Null to dynamic
  double? finalPrice; // Changed from int to double
  double? minPrice; // Changed from int to double
  double? maxPrice; // Changed from int to double
  String? priceRange;
  int? totalStock;
  bool? isAvailable;
  bool? inStock;
  List<Variant>? variants;

  DataWish({
    this.id,
    this.uuid,
    this.name,
    this.slug,
    this.description,
    this.price,
    this.discountPrice,
    this.stock,
    this.categoryId,
    this.images,
    this.imageModels,
    this.isActive,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.finalPrice,
    this.minPrice,
    this.maxPrice,
    this.priceRange,
    this.totalStock,
    this.isAvailable,
    this.inStock,
    this.variants,
  });

  factory DataWish.fromJson(Map<String, dynamic> json) {
    return DataWish(
      id: json['id'],
      uuid: json['uuid'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      price: json['price'],
      discountPrice: json['discount_price'], // Can be String or null
      stock: json['stock'],
      categoryId: json['category_id'],
      images: _parseImages(json['images']), // Fixed image parsing
      imageModels: _parseImageModels(json['images']),
      isActive: json['is_active'],
      image: json['image'], // Can be String or null
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      finalPrice: _parseDouble(json['final_price']),
      minPrice: _parseDouble(json['min_price']),
      maxPrice: _parseDouble(json['max_price']),
      priceRange: json['price_range'],
      totalStock: json['total_stock'],
      isAvailable: json['is_available'],
      inStock: json['in_stock'],
      variants: json['variants'] != null
          ? List<Variant>.from(json['variants'].map((x) => Variant.fromJson(x)))
          : null,
    );
  }

  static List<String>? _parseImages(dynamic imagesData) {
    if (imagesData == null) return null;
    
    if (imagesData is List) {
      return List<String>.from(imagesData);
    }
    
    if (imagesData is String) {
      try {
        // Handle JSON string format: "[\"url1\",\"url2\"]"
        final cleaned = imagesData.replaceAll(r'\/', '/');
        final parsed = json.decode(cleaned) as List;
        return List<String>.from(parsed);
      } catch (e) {
        // If it's already a simple string URL, return as list
        return [imagesData];
      }
    }
    
    return null;
  }

  static List<ImageModel>? _parseImageModels(dynamic imagesData) {
    final images = _parseImages(imagesData);
    if (images == null) return null;
    
    return images.map((imageUrl) => ImageModel(src: imageUrl)).toList();
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'slug': slug,
      'description': description,
      'price': price,
      'discount_price': discountPrice,
      'stock': stock,
      'category_id': categoryId,
      'images': images,
      'is_active': isActive,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'final_price': finalPrice,
      'min_price': minPrice,
      'max_price': maxPrice,
      'price_range': priceRange,
      'total_stock': totalStock,
      'is_available': isAvailable,
      'in_stock': inStock,
      'variants': variants?.map((v) => v.toJson()).toList(),
    };
  }

  /// Helper to get display price
  String get displayPrice {
    if (finalPrice != null) {
      return '$finalPrice';
    }
    return price ?? '0.00';
  }

  /// Helper to check if product has discount
  bool get hasDiscount => discountPrice != null && discountPrice!.isNotEmpty;

  /// Helper to get primary image
  String? get primaryImage {
    if (images != null && images!.isNotEmpty) {
      return images!.first;
    }
    return null;
  }

  /// Convert to ProductModel for compatibility
  ProductModel toProductModel() {
    return ProductModel(
      success: true,
      data: [
        Data(
          id: id,
          name: name,
          slug: slug,
          description: description,
          minPrice: minPrice,
          maxPrice: maxPrice,
          inStock: inStock,
          isActive: isActive,
          category: categoryId != null 
              ? Category(id: categoryId, name: '', slug: '')
              : null,
          variants: variants?.map((v) => Variants(
            id: v.id,
            sku: v.sku,
            price: v.price,
            stock: v.stock,
            stockStatus: (v.stock ?? 0) > 0 ? 'in_stock' : 'out_of_stock',
            image: v.image,
            options: v.optionValues?.map((ov) => ov.value ?? '').toList() ?? [],
          )).toList() ?? [],
        ),
      ],
    );
  }
}

class Variant {
  int? id;
  int? productId;
  String? sku;
  String? price;
  int? stock;
  String? image;
  String? createdAt;
  String? updatedAt;
  List<OptionValue>? optionValues;

  Variant({
    this.id,
    this.productId,
    this.sku,
    this.price,
    this.stock,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.optionValues,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      productId: json['product_id'],
      sku: json['sku'],
      price: json['price'],
      stock: json['stock'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      optionValues: json['option_values'] != null
          ? List<OptionValue>.from(
              json['option_values'].map((x) => OptionValue.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'sku': sku,
      'price': price,
      'stock': stock,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'option_values': optionValues?.map((v) => v.toJson()).toList(),
    };
  }
}

class OptionValue {
  int? id;
  int? optionId;
  String? value;
  String? priceModifier;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  OptionValue({
    this.id,
    this.optionId,
    this.value,
    this.priceModifier,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory OptionValue.fromJson(Map<String, dynamic> json) {
    return OptionValue(
      id: json['id'],
      optionId: json['option_id'],
      value: json['value'],
      priceModifier: json['price_modifier'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'option_id': optionId,
      'value': value,
      'price_modifier': priceModifier,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pivot': pivot?.toJson(),
    };
  }
}

class Pivot {
  int? variantId;
  int? optionValueId;

  Pivot({this.variantId, this.optionValueId});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      variantId: json['variant_id'],
      optionValueId: json['option_value_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'variant_id': variantId,
      'option_value_id': optionValueId,
    };
  }
}