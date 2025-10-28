import 'package:khouyot/core/models/image_product_model.dart';
import 'package:khouyot/features/favorite/data/models/wish_list_model.dart';

/// ======================
/// Product Model
/// ======================
class ProductModel {
  bool? success;
  List<Data>? data;
  Meta? meta;

  ProductModel({this.success, this.data, this.meta});

  ProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      map['meta'] = meta!.toJson();
    }
    return map;
  }
}

class Data {
  int? id;
  String? name;
  String? slug;
  String? description;
  double? basePrice;
  double? minPrice;
  double? maxPrice;
  bool? inStock;
  bool? isActive;
  int? views;
  Category? category;
  List<Options>? options;
  List<Variants>? variants;

  Data({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.basePrice,
    this.minPrice,
    this.maxPrice,
    this.inStock,
    this.isActive,
    this.views,
    this.category,
    this.options,
    this.variants,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    basePrice = _parseDouble(json['base_price']);
    minPrice = _parseDouble(json['min_price']);
    maxPrice = _parseDouble(json['max_price']);
    inStock = json['in_stock'];
    isActive = json['is_active'];
    views = json['views'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['description'] = description;
    map['base_price'] = basePrice;
    map['min_price'] = minPrice;
    map['max_price'] = maxPrice;
    map['in_stock'] = inStock;
    map['is_active'] = isActive;
    map['views'] = views;
    if (category != null) {
      map['category'] = category!.toJson();
    }
    if (options != null) {
      map['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (variants != null) {
      map['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  /// Helper method to get display price
  String get displayPrice {
    if (minPrice != null && maxPrice != null) {
      if (minPrice == maxPrice) {
        return '${minPrice!.toStringAsFixed(2)}';
      } else {
        return '${minPrice!.toStringAsFixed(2)} - ${maxPrice!.toStringAsFixed(2)}';
      }
    } else if (minPrice != null) {
      return '${minPrice!.toStringAsFixed(2)}';
    } else if (basePrice != null) {
      return '${basePrice!.toStringAsFixed(2)}';
    }
    return '0.00';
  }

  /// Helper method to get primary image from variants
  String? get primaryImage {
    if (variants != null && variants!.isNotEmpty) {
      for (var variant in variants!) {
        if (variant.image != null && variant.image!.isNotEmpty) {
          return variant.image;
        }
      }
    }
    return null;
  }

  /// Helper method to check if product has variants
  bool get hasVariants => variants != null && variants!.isNotEmpty;

  /// Helper method to check if product has options
  bool get hasOptions => options != null && options!.isNotEmpty;
}

class Category {
  int? id;
  String? name;
  String? slug;

  Category({this.id, this.name, this.slug});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    return map;
  }
}

class Options {
  int? id;
  String? name;
  int? required;
  List<Values>? values;

  Options({this.id, this.name, this.required, this.values});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    required = json['required'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['required'] = required;
    if (values != null) {
      map['values'] = values!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  /// Helper to check if option is required
  bool get isRequired => required == 1;
}

class Values {
  int? id;
  String? value;
  String? priceModifier;

  Values({this.id, this.value, this.priceModifier});

  Values.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    priceModifier = json['price_modifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['value'] = value;
    map['price_modifier'] = priceModifier;
    return map;
  }

  /// Helper to get price modifier as double
  double get priceModifierAsDouble {
    if (priceModifier == null) return 0.0;
    return double.tryParse(priceModifier!) ?? 0.0;
  }
}

class Variants {
  int? id;
  String? sku;
  String? price;
  int? stock;
  String? stockStatus;
  String? image;
  List<String>? options;

  Variants({
    this.id,
    this.sku,
    this.price,
    this.stock,
    this.stockStatus,
    this.image,
    this.options,
  });

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    price = json['price'];
    stock = json['stock'];
    stockStatus = json['stock_status'];
    image = json['image'];
    options = json['options'] != null ? List<String>.from(json['options']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['sku'] = sku;
    map['price'] = price;
    map['stock'] = stock;
    map['stock_status'] = stockStatus;
    map['image'] = image;
    map['options'] = options;
    return map;
  }

  /// Helper to get price as double
  double get priceAsDouble {
    if (price == null) return 0.0;
    return double.tryParse(price!) ?? 0.0;
  }

  /// Helper to check if variant is in stock
  bool get isInStock => stockStatus == 'in_stock' && (stock == null || stock! > 0);

  /// Helper to get full image URL (you might need to prepend base URL)
  String? get fullImageUrl {
    if (image == null) return null;
    // Add your base URL here if needed
    // return 'https://your-domain.com/storage/$image';
    return image;
  }
}

class Meta {
  int? currentPage;
  int? total;
  int? perPage;
  int? lastPage;

  Meta({this.currentPage, this.total, this.perPage, this.lastPage});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    total = json['total'];
    perPage = json['per_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['current_page'] = currentPage;
    map['total'] = total;
    map['per_page'] = perPage;
    map['last_page'] = lastPage;
    return map;
  }

  /// Helper to check if there's more pages
  bool get hasMorePages => currentPage != null && lastPage != null && currentPage! < lastPage!;
}

/// ======================
/// Extensions (Mappers)
/// ======================

// ProductModel → WishListModel
extension ProductModelMapper on ProductModel {
  DataWish convertToFav() {
    if (data == null || data!.isEmpty) {
      return DataWish(
        id: 0, 
        name: "", 
        description: "", 
        price: "0", 
        images: [],
        imageModels: [],
      );
    }
    return data!.first.convertToFav();
  }
}

// Data → WishListModel
extension DataMapper on Data {
  DataWish convertToFav() {
    return DataWish(
      id: id ?? 0,
      name: name ?? "",
      description: _cleanDescription(description ?? ""),
      price: displayPrice,
      images: primaryImage != null ? [primaryImage!] : [],
      imageModels: primaryImage != null 
          ? [ImageModel(src: primaryImage!)]
          : [],
    );
  }

  String _cleanDescription(String htmlDescription) {
    // Remove HTML tags and clean the description
    return htmlDescription
        .replaceAll(RegExp(r'<[^>]*>'), '') // Remove HTML tags
        .replaceAll(RegExp(r'\s+'), ' ') // Replace multiple spaces with single space
        .trim();
  }
}

// Variants → WishListModel
extension VariantsMapper on Variants {
  DataWish convertToFav({String? productName, String? description}) {
    return DataWish(
      id: id ?? 0,
      name: productName ?? "Unknown",
      description: description ?? "",
      price: price ?? "0",
      images: image != null ? [image!] : [],
      imageModels: image != null 
          ? [ImageModel(src: image!)]
          : [],
    );
  }
}

/// Additional helper extension for product list operations
extension ProductListExtensions on List<Data> {
  /// Filter products by category ID
  List<Data> filterByCategory(int categoryId) {
    return where((product) => product.category?.id == categoryId).toList();
  }

  /// Filter products by category slug
  List<Data> filterByCategorySlug(String slug) {
    return where((product) => product.category?.slug == slug).toList();
  }

  /// Filter products in stock
  List<Data> get inStockProducts {
    return where((product) => product.inStock == true).toList();
  }

  /// Filter active products
  List<Data> get activeProducts {
    return where((product) => product.isActive == true).toList();
  }

  /// Sort by price (low to high)
  List<Data> sortByPriceAsc() {
    return [...this]..sort((a, b) => (a.minPrice ?? 0).compareTo(b.minPrice ?? 0));
  }

  /// Sort by price (high to low)
  List<Data> sortByPriceDesc() {
    return [...this]..sort((a, b) => (b.minPrice ?? 0).compareTo(a.minPrice ?? 0));
  }
}