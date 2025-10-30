import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/di/Dependency_inj.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/features/cart/data/models/cart_item_model.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/home/ui/widgets/incream_decream.dart';
import 'package:khouyot/features/product_details/ui/widget/select_color_item.dart';
import 'package:khouyot/features/product_details/ui/widget/select_size_item.dart';
import 'package:khouyot/generated/l10n.dart';

import '../../data/model/prodec_details_model.dart';

Future<void> showAddToCartBottomSheet(BuildContext cont, Data model) {
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0.r),
    ),
    context: cont,
    builder: (BuildContext context) {
      return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: getIt<HomeCubit>(),
            ),
            BlocProvider.value(
              value: getIt<CartCubit>(),
            ),
          ],
          child: BlocBuilder<CartCubit, CartState>(
            builder: (newContext, state) {
              return BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Container(
                    color: ThemeCubit.get(context).themeMode == ThemeMode.light
                        ? ColorsManager.mainWhite
                        : ColorsManager.kSecondaryColor,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(newContext).viewInsets.bottom,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          mainAxisSize: MainAxisSize
                              .min, // Ensures the sheet height is minimized
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).ChooseYourDetails,
                                    style: TextStyles.font20KprimaryMedium,
                                  ),
                                  IconButton(
                                    onPressed: () => Navigator.pop(newContext),
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                return SelectColorItem(
                                  onTap: HomeCubit.get(newContext)
                                      .changeSelectedColor2,
                                  selectedColor:
                                      HomeCubit.get(newContext).selectedColor2,
                                );
                              },
                            ),
                            verticalSpace(20),
                            BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                return SelectSizeItem(
                                  onTap: HomeCubit.get(newContext)
                                      .changeSelectedSize2,
                                  selectedSize:
                                      HomeCubit.get(newContext).selectedSize2,
                                );
                              },
                            ),
                            verticalSpace(20),
                            const IncreamDecream(),
                            verticalSpace(20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: AppTextButton(
                                buttonText: S.of(context).AddToCart,
                                textStyle: TextStyles.font18WhiteMedium,
                                onPressed: () {
                                  if (HomeCubit.get(newContext).num == 0)
                                    return;
                                  CartCubit.get(newContext).addToCart(
                                      CartItemModel(
                                          productModel: model,
                                          quantity:
                                              HomeCubit.get(newContext).num));
                                  Navigator.pop(
                                      newContext); // Close the bottom sheet after adding
                                },

                                // buttonWidth: 280.w,
                                buttonHeight: 35.h,
                                backgroundColor: ColorsManager.kPrimaryColor,
                                //verticalPadding: 10,
                              ),
                            ),
                            verticalSpace(30),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ));
    },
  );
}
