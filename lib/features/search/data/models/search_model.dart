// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SearchModel {
  String search;
  String? minPrice;
  String? maxPrice;
  String? currentCategory;
  SearchModel({
    required this.search,
    this.minPrice,
    this.maxPrice,
    this.currentCategory,
  });


  SearchModel copyWith({
    String? search,
    String? minPrice,
    String? maxPrice,
    String? currentCategory,
  }) {
    return SearchModel(
      search: search ?? this.search,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      currentCategory: currentCategory ?? this.currentCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'search': search,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'currentCategory': currentCategory,
    };
  }
    Map<String, dynamic> searchBody() {
      Map<String, dynamic> body = {"search": search};
      if (minPrice != null) {
      body['min_price'] = minPrice;
      }if (maxPrice != null) {
      body['max_price'] = maxPrice;
      }
      if (currentCategory != null) {
      body['category'] = currentCategory;
      }
      return body;
  }

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      search: map['search'] as String,
      minPrice: map['minPrice'] != null ? map['minPrice'] as String : null,
      maxPrice: map['maxPrice'] != null ? map['maxPrice'] as String : null,
      currentCategory: map['currentCategory'] != null ? map['currentCategory'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchModel.fromJson(String source) => SearchModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SearchModel(search: $search, minPrice: $minPrice, maxPrice: $maxPrice, currentCategory: $currentCategory)';
  }

  @override
  bool operator ==(covariant SearchModel other) {
    if (identical(this, other)) return true;
  
    return
      other.search == search &&
      other.minPrice == minPrice &&
      other.maxPrice == maxPrice &&
      other.currentCategory == currentCategory;
  }

  @override
  int get hashCode {
    return search.hashCode ^
      minPrice.hashCode ^
      maxPrice.hashCode ^
      currentCategory.hashCode;
  }
}
