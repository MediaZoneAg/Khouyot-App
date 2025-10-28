
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/cart/ui/widgets/card_info_widget.dart';
import 'package:khouyot/features/cart/ui/widgets/payment_info_item.dart';
import 'package:khouyot/features/cart/ui/widgets/total_price_widget.dart';

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFFEDEDED),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50 + 16, left: 22, right: 22),
        child: Column(
          children: [
            Text(
              'Thank you!',
              textAlign: TextAlign.center,
              style: TextStyles.font20BlackMedium
            ),
            Text(
              'Your transaction was successful',
              textAlign: TextAlign.center,
              style: TextStyles.font18BlackRegular
            ),
            verticalSpace(30),
            PaymentItemInfo(
              title: 'Date',
              value: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            ),
            verticalSpace(
                15,
            ),
            PaymentItemInfo(
              title: 'Time',
              value: "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().hour >= 12 ? 'PM' : 'AM'}",
            ),
            verticalSpace(
                15,
            ),
            PaymentItemInfo(
              title: 'To',
              value: "${CashHelper.getString(key: Keys.cardHolderName, )}",
            ),
            Divider(
              height: 30.h,
              thickness: 2,
            ),
            TotalPrice(title: 'Total', value: '${CartCubit.get(context).total} EGP'),
            verticalSpace(15),
            const CardInfoWidget(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  FontAwesomeIcons.barcode,
                  size: 65.sp,
                ),
                InkWell(
                  onTap: () {
                    context.pushNamedAndRemoveUntil(Routes.checkOutScreen, predicate: (Route<dynamic> route) => false);
                  },
                  child: Container(
                    width: 113.w,
                    height: 55.h,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1.50, color: ColorsManager.kPrimaryColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'PAID',
                        textAlign: TextAlign.center,
                        style: TextStyles.font24KprimaryMedium
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: ((MediaQuery.sizeOf(context).height * .2 + 20) / 2) - 29,
            ),
          ],
        ),
      ),
    );
  }
}
