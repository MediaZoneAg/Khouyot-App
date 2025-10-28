class FilterCategory {
  final int id;
  final String name;
  final String slug;
  final bool isSelected;

  FilterCategory({
    required this.id,
    required this.name,
    required this.slug,
    this.isSelected = false,
  });

  FilterCategory copyWith({
    int? id,
    String? name,
    String? slug,
    bool? isSelected,
  }) {
    return FilterCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}