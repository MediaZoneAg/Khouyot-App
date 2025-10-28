import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/category/ui/widgets/sub_category_item.dart';

class UiLoadingCategoryProducts extends StatelessWidget {
  const UiLoadingCategoryProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          CategoryCubit.get(context).productSubSubCategoriesList.length * 160.h,
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0.w,
          childAspectRatio: 0.76,
          mainAxisExtent: 275.h,
        ),
        children: [
          ...CategoryCubit.get(context)
              .productSubSubCategoriesList
              .map((e) => SubCategoryItem(
                    productModel: ProductModel(data: [
                      Data(
                        id: 0,
                        name: "Product 1",
                        description: "Description here",
                        minPrice: 25,
                        maxPrice: 25,
                        category: Category(
                            id: 1, name: "Category A", slug: "category-a"),
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
                      )
                    ]),
                    onTap1: () {},
                    isClicked: false,
                    onTap2: () async {},
                  ))
        ],
      ),
    );
  }
}
