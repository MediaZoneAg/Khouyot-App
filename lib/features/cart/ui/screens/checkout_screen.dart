import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/core/widgets/custom_app_bar.dart';
import 'package:khouyot/features/cart/data/models/line_item.dart';
import 'package:khouyot/features/cart/data/models/order_model.dart';
import 'package:khouyot/features/cart/data/models/shipping_lines_model.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/cart/ui/widgets/cart_details.dart';
import 'package:khouyot/features/cart/ui/widgets/payment_option_tile.dart';
import 'package:khouyot/features/cart/ui/widgets/paymob_states.dart';
import 'package:khouyot/features/cart/ui/widgets/request_state_ui.dart';
import 'package:khouyot/features/home/ui/widgets/add_to_cart_button.dart';
import 'package:khouyot/features/location/ui/widgets/location_container.dart';
import 'package:khouyot/generated/l10n.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return AddToCartPriceButton(
                text: S.of(context).PlaceOrder,
                price: CartCubit.get(context).total,
                onTap: () {
                  for (var element in CartCubit.get(context).cartItemList) {
                    CartCubit.get(context).lineItems = [
                      LineItems(
                          quantity: element.quantity,
                          productId: element.productModel.data?.first.id!.toInt(),
                          variationId: 0)
                    ];
                  }
                  CartCubit.get(context).orderModel = OrderModel(
                      shippingLines: [
                        ShippingLines(
                            methodId: 'flat_rate',
                            methodTitle: 'flat_rate',
                            total: '10')
                      ],
                      lineItems: CartCubit.get(context).lineItems,
                      paymentMethod:
                          CartCubit.get(context).selectedPaymentMethod ??
                              S.of(context).cash,
                      paymentMethodTitle:
                          CartCubit.get(context).selectedPaymentMethod ??
                              S.of(context).card,
                      billing: CartCubit.get(context).billing,
                      shipping: CartCubit.get(context).shipping,
                      setPaid: false);
                      if(CartCubit.get(context).selectedPaymentMethod==S.of(context).cash){
                        CartCubit.get(context).placeOrder();
                      }else{
                        CartCubit.get(context).pay(CartCubit.get(context).total, CartCubit.get(context).billing);
                      }
                 // CartCubit.get(context).placeOrder();
                },
              );
            },
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    barIcon: Icons.arrow_back_ios,
                    onPressed: () {
                      context.pop();
                    },
                    title: S.of(context).Checkout,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0.w,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height: CartCubit.get(context).cartItemList.length *
                                140.h,
                            child: ListView.builder(
                                itemCount:
                                    CartCubit.get(context).cartItemList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CartDetailsItem(
                                      cartItemModel: CartCubit.get(context)
                                          .cartItemList[index],
                                      increase: () {
                                        CartCubit.get(context)
                                            .changeItemCountPlus(index);
                                      },
                                      decrease: () {
                                        CartCubit.get(context)
                                            .changeItemCountRemove(index);
                                      },
                                      text: CartCubit.get(context)
                                          .cartItemList[index]
                                          .quantity
                                          .toString(),
                                    ),
                                  );
                                })),
                        verticalSpace(10),
                        LocationContainer(
                          location:
                              "${CashHelper.getString(key: Keys.city)} ,${CashHelper.getString(key: Keys.address)},${CashHelper.getString(key: Keys.floor)}",
                        ),
                        verticalSpace(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.of(context).PayWith,
                                style: TextStyles.font18KprimaryMedium),
                            verticalSpace(10),
                            BlocBuilder<CartCubit, CartState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    const PaymentOptionTile(
                                      title: 'Cash',
                                      value: 'Cash',
                                      iconPath: AssetsData.cash,
                                    ),
                                    
                                    verticalSpace(10),
                                    PaymentOptionTile(
                                      title: 'Card',
                                      value: 'Card',
                                      iconPath: AssetsData.cash,
                                    )
                                    // AddButton(
                                    //   onTap: () {
                                    //     context.pushNamed(
                                    //         Routes.peymentDetailsScreen);
                                    //   },
                                    // ),
                                  ],
                                );
                              },
                            ),
                            verticalSpace(20),
                            Text(
                              S.of(context).Discountcode,
                              style: TextStyles.font16BlackRegular.copyWith(
                                  color: ThemeCubit.get(context).themeMode ==
                                          ThemeMode.light
                                      ? Colors.black
                                      : ColorsManager.mainWhite),
                            ),
                            verticalSpace(5),
                            AppTextFormField(
                                hintText: S.of(context).DiscountcodeDes,
                                hintStyle: TextStyles.font16DarkgreyRegular
                                    .copyWith(
                                        color:
                                            ThemeCubit.get(context).themeMode ==
                                                    ThemeMode.light
                                                ? ColorsManager.darkGrey
                                                : ColorsManager.grey),
                                borderRadius: 10,
                                suffixIcon: AppTextButton(
                                    buttonText: S.of(context).Apply,
                                    buttonWidth: 100,
                                    textStyle: TextStyles.font16KprimaryRegular,
                                    backgroundColor: Colors.transparent,
                                    onPressed: () {}))
                          ],
                        ),
                        const RequestStateUi(),
                        PayMobStates(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
