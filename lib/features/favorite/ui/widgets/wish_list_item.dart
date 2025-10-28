import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/favorite/data/models/wish_list_model.dart';

class WishListItem extends StatelessWidget {
  const WishListItem(
      {super.key,
      required this.onTap1,
      required this.wishListModel,
      required this.onTap2,
      required this.isClicked});
  final VoidCallback onTap1;
  final DataWish wishListModel;
  final VoidCallback onTap2;
  final bool isClicked;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(children: [
            GestureDetector(
              onTap: onTap1,
              child: SizedBox(
                width: 165.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //if(productModel.images!.isNotEmpty)
                    AppCachedNetworkImage(
                      image: wishListModel.images![0],
                      width: 165.w,
                      height: 165.h,
                      radius: 10.r,
                    ),
                    verticalSpace(5),
                    Text(
                      wishListModel.name ?? "Green Tall Coat",
                      style: TextStyles.font16Black.copyWith(
                          color: ThemeCubit.get(context).themeMode ==
                                  ThemeMode.light
                              ? Colors.black
                              : ColorsManager.mainWhite),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(7),
                    Text(
                      "EGP ${wishListModel.price ?? "25 EGP"}",
                      style: TextStyles.font16KprimaryRegular,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 10.h,
                left: 105.w,
                child: GestureDetector(
                  onTap: onTap2,
                  child: Container(
                      width: 37.w,
                      height: 37.h,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.7),
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20.sp,
                      )),
                ))
          ]),
        );
      },
    );
  }
}
