import 'package:flutter/material.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/features/home/ui/widgets/category_item.dart';

class UiLoadingPagination extends StatelessWidget {
  const UiLoadingPagination({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy product to render a loading-looking tile
    final dummy = Data(
      id: 0,
      name: "Loading...",
      description: "Loading...",
      minPrice: 0,
      maxPrice: 0,
      category: Category(id: 0, name: "Loading", slug: "loading"),
      variants: [
        Variants(
          id: 0,
          sku: "LOADING",
          price: "0",
          stock: 0,
          stockStatus: "in_stock",
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbzP5tsc2Hiy2r5O1Y6OMtT4iIz903c0a7iQ&s",
        ),
      ],
    );

    return CategoryItem(
      product: dummy,          
      isClicked: false,
      onTap1: () {},
      onTap2: () {},
    );
  }
}
