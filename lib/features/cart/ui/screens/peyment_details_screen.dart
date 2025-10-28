import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/cart/ui/screens/paymob_screen.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          appBar: AppBar(
            title: const Text("Payment Details"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => context.pop(),
            ),
            backgroundColor: ColorsManager.kPrimaryColor,
          ),
          body: Column(
            children: [
              Expanded(
                child: PayMobScreen(), 
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppTextButton(
                  buttonText: "Add Card",
                  textStyle: TextStyles.font18WhiteMedium,
                  buttonHeight: 50.h,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      final card = {
                        'cardNum': CartCubit.get(context)
                            .cardNumber
                            .substring(15), // آخر 4 أرقام
                        'cardHolderName': CartCubit.get(context).cardHolderName,
                        'expiryDate': CartCubit.get(context).expiryDate,
                        'cvv': CartCubit.get(context).cvvCode,
                      };
                      final existingCards =
                          CashHelper.getList(key: Keys.cardsList) ?? [];
                      existingCards.add(card);
                      CashHelper.putList(
                          key: Keys.cardsList, value: existingCards);
                      context.pushNamed(Routes.checkOutScreen);
                      CartCubit.get(context).cardNumber = '';
                      CartCubit.get(context).expiryDate = '';
                      CartCubit.get(context).cardHolderName = '';
                      CartCubit.get(context).cvvCode = '';
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  backgroundColor: ColorsManager.kPrimaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
