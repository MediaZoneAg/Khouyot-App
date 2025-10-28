import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/models/image_product_model.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/features/favorite/data/models/wish_list_model.dart';
import 'package:khouyot/features/favorite/ui/widgets/wish_list_item.dart';

class UiLoadingWishList extends StatelessWidget {
  const UiLoadingWishList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0.w,
        childAspectRatio: 0.76,
        mainAxisExtent: 275.h,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return WishListItem(
          isClicked: false,
          wishListModel:
              DataWish(
                id: 0,
                name: "hhhhhh",
                price: "202",
                imageModels: [
                  ImageModel(
                    id: 0,
                    src:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbzP5tsc2Hiy2r5O1Y6OMtT4iIz903c0a7iQ&s',
                  )
                
            ],
          ),
          onTap1: () {},
          onTap2: () {},
        );
      },
    );
  }
}
