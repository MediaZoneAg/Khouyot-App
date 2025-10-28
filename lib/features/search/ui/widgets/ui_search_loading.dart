
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/features/search/ui/widgets/search_item.dart';

class UiLoadingSearch extends StatelessWidget {
  const UiLoadingSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
                        crossAxisSpacing: 12.0.w,
                        childAspectRatio: 0.76,
                        mainAxisExtent: 270.h,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return SearchResultItem(
          productModel: ProductModel(
          data: [
          Data(id: 0,
    name: "Product 1",
    description: "Description here",
    minPrice: 25,
    maxPrice: 25,
    category: Category(id: 1, name: "Category A", slug: "category-a"),
    variants: [
      Variants(
        id: 1,
        sku: "SKU001",
        price: "25",
        stock: 10,
        stockStatus: "in_stock",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbzP5tsc2Hiy2r5O1Y6OMtT4iIz903c0a7iQ&s",
      ),
    ],)
        ],
   ),
          onTap1: () {},
          onTap2: () {},
          isClicked: false,
        );
      },
    );
  }
}
