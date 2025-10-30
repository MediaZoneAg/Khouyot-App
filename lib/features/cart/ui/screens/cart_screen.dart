import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/khouyot.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/functions/snak_bar.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_category_app_bar.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/cart/ui/widgets/cart_item.dart';
import 'package:khouyot/generated/l10n.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    CartCubit.get(context).getCart();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor:
                  ThemeCubit.get(context).themeMode == ThemeMode.light
                      ? ColorsManager.mainWhite
                      : ColorsManager.kSecondaryColor,
              bottomNavigationBar: CartCubit.get(context)
                      .cartItemList
                      .isNotEmpty
                  ? BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: AppTextButton(
                            buttonText: S.of(context).ProccedToCheckout,
                            textStyle: TextStyles.font18WhiteMedium,
                            //verticalPadding: 3.h,
                            buttonHeight: 40.h,
                            onPressed: () async {
                              if (await CashHelper.getStringSecured(
                                      key: Keys.token) !=
                                  "") {
                                context.pushNamed(
                                    Routes.chooseLocationOptionsScreen);
                              } else {
                                showSnackBar(
                                    context: NavigationService
                                        .navigatorKey.currentState!.context,
                                    text: S.of(context).Youneedtologinfirst);
                                context.pushNamedAndRemoveUntil(
                                    Routes.enteranceScreen,
                                    predicate: (Route<dynamic> route) => false);
                              }
                            },
                            backgroundColor: ColorsManager.kPrimaryColor,
                          ),
                        );
                      },
                    )
                  : Container(
                      height: 50.h,
                      width: double.infinity,
                    ),
              body: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 16.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CategoryAppBar(
                          title: S.of(context).Cart,
                          width: 0,
                          // content: Icon(
                          //   Icons.arrow_back_ios,
                          //   color: ThemeCubit.get(context).themeMode ==
                          //           ThemeMode.light
                          //       ? ColorsManager.darkBlack
                          //       : ColorsManager.mainWhite,
                          // ),
                          btn1: Padding(
                            padding: EdgeInsets.only(left: 230.w),
                            child: CustomSvg(
                              imgPath: AssetsData.delete,
                              color: ThemeCubit.get(context).themeMode ==
                                      ThemeMode.light
                                  ? ColorsManager.darkBlack
                                  : ColorsManager.mainWhite,
                            ),
                          ),
                          btn2: CustomSvg(
                            imgPath: AssetsData.favriote,
                            color: ThemeCubit.get(context).themeMode ==
                                    ThemeMode.light
                                ? ColorsManager.darkBlack
                                : ColorsManager.mainWhite,
                          ),
                          onTap1: () {
                            //context.pop();
                          },
                          onTap2: () async {
                            if (await CashHelper.getStringSecured(
                                    key: Keys.token) !=
                                "") {
                              CartCubit.get(context).clearCart();
                            } else {
                              showSnackBar(
                                  context: NavigationService
                                      .navigatorKey.currentState!.context,
                                  text: S.of(context).Youneedtologinfirst);
                            }
                          },
                          onTap3: () async {
                            if (await CashHelper.getStringSecured(
                                    key: Keys.token) !=
                                "") {
                              context.pushNamed(Routes.wishListScreen);
                            } else {
                              showSnackBar(
                                  context: NavigationService
                                      .navigatorKey.currentState!.context,
                                  text: S.of(context).Youneedtologinfirst);
                            }
                          },
                        ),
                        verticalSpace(20),
                        // Selected Item Display
                        BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            return CartCubit.get(context)
                                    .cartItemList
                                    .isNotEmpty
                                ? SizedBox(
                                    height: CartCubit.get(context)
                                            .cartItemList
                                            .length *
                                        200.h,
                                    child: ListView.builder(
                                        itemCount: CartCubit.get(context)
                                            .cartItemList
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CartItem(
                                              onRemove: () {
                                                CartCubit.get(context)
                                                    .removeFromCart(CartCubit
                                                            .get(context)
                                                        .cartItemList[index]);
                                              },
                                              cartItemModel:
                                                  CartCubit.get(context)
                                                      .cartItemList[index],
                                              increase: () {
                                                CartCubit.get(context)
                                                    .changeItemCountPlus(index);
                                              },
                                              decrease: () {
                                                CartCubit.get(context)
                                                    .changeItemCountRemove(
                                                        index);
                                              },
                                              text: CartCubit.get(context)
                                                  .cartItemList[index]
                                                  .quantity
                                                  .toString(),
                                            ),
                                          );
                                        }))
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 140.0.h),
                                    child: Lottie.asset(
                                      AssetsData.empty,
                                    ),
                                  );
                          },
                        )
                        // Text(
                        //   S.of(context).Youmightliketofititwith,
                        //   style: TextStyles.font16KprimaryRegular,
                        // ),
                        // verticalSpace(20),
                        // // ListView for Cart Items
                        // SizedBox(
                        //   height: 250.h,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: CartCubit.get(context).cartList.length,
                        //     itemBuilder: (context, index) {
                        //       final item = CartCubit.get(context).cartList[index];
                        //       return CartListViewItem(
                        //         cartModel: item,
                        //         onTap: () {
                        //           CartCubit.get(context)
                        //               .selectItem(item); // Update selected item on tap
                        //         },
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
