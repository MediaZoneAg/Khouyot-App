import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/features/home/ui/widgets/category_item.dart';

class UiLoadingProducts extends StatelessWidget {
  const UiLoadingProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0.w,
        childAspectRatio: 0.76,
        mainAxisExtent: 270.h,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        final dummy = Data(
          id: 0,
          name: "Loading...",
          description: "Loading...",
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
              image:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbzP5tsc2Hiy2r5O1Y6OMtT4iIz903c0a7iQ&s",
            ),
          ],
        );

        return CategoryItem(
          product: dummy, // ✅ FIXED: use Data instead of ProductModel
          isClicked: false,
          onTap1: () {},
          onTap2: () {},
        );
      },
    );
  }
}
