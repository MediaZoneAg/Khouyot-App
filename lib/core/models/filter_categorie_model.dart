// Update your FilterCategorieModel to handle the API response correctly
class FilterCategorieModel {
  List<CategoryData>? data;

  FilterCategorieModel({this.data});

  FilterCategorieModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Get only top-level categories for the filter list
  List<CategoryData> get topLevelCategories {
    if (data == null) return [];
    return data!.where((category) => category.parentId == null).toList();
  }
}

class CategoryData {
  int? id;
  String? name;
  String? slug;
  int? parentId;
  List<CategoryData>? children;

  CategoryData({
    this.id,
    this.name,
    this.slug,
    this.parentId,
    this.children,
  });

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parentId = json['parent_id'];
    if (json['children'] != null) {
      children = <CategoryData>[];
      json['children'].forEach((v) {
        children!.add(CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['parent_id'] = parentId;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Get display name without leading dashes
  String get displayName {
    if (name == null) return '';
    return name!.replaceAll(RegExp(r'^-+\s*'), '').trim();
  }

  bool get isTopLevel => parentId == null;
}