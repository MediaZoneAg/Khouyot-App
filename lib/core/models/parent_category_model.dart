import 'package:khouyot/core/models/image_category_model.dart';

class ParentCategoryModel {
  bool? success;
  Category? category;
  List<Products>? products;
  List<ImageCategoryModel>? images;
  List<ParentCategoryModel> subCategories =[];

  Meta? meta;

  ParentCategoryModel({
    this.success,
    this.category,
    this.products,
    this.images,
    this.meta,
  });

  ParentCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;

    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }

    if (json['images'] != null) {
      images = <ImageCategoryModel>[];
      json['images'].forEach((v) {
        images!.add(ImageCategoryModel.fromMap(v));
      });
    }

    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['success'] = success;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toMap()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }

    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  int? parentId;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.slug,
    this.parentId,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['parent_id'] = parentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? slug;
  int? minPrice;
  int? maxPrice;
  bool? inStock;
  String? image;

  Products({
    this.id,
    this.name,
    this.slug,
    this.minPrice,
    this.maxPrice,
    this.inStock,
    this.image,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    inStock = json['in_stock'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['in_stock'] = inStock;
    data['image'] = image;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? total;
  int? perPage;
  int? lastPage;
  int? from;
  int? to;

  Meta({
    this.currentPage,
    this.total,
    this.perPage,
    this.lastPage,
    this.from,
    this.to,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    total = json['total'];
    perPage = json['per_page'];
    lastPage = json['last_page'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['total'] = total;
    data['per_page'] = perPage;
    data['last_page'] = lastPage;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
