

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CustomCreditCard extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final AutovalidateMode autovalidateMode;

//   const CustomCreditCard({
//     super.key,
//     required this.formKey,
//     required this.autovalidateMode,
//   });

//   @override
//   Widget build(BuildContext context) {
//     //final cartCubit = CartCubit.get(context);

//     return BlocBuilder<CartCubit, CartState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             CreditCardWidget(
//               cardNumber: CartCubit.get(context).cardNumber,
//               expiryDate: CartCubit.get(context).expiryDate,
//               cardBgColor: ColorsManager.kPrimaryColor,
//               cardHolderName: CartCubit.get(context).cardHolderName,
//               cvvCode: CartCubit.get(context).cvvCode,
//               showBackView: CartCubit.get(context).showBackView,
//               isHolderNameVisible: true,
//               onCreditCardWidgetChange: (value) {},
//             ),
//             CreditCardForm(
//               isHolderNameVisible: true,
//               autovalidateMode: autovalidateMode,
//               cardNumber: CartCubit.get(context).cardNumber,
//               expiryDate: CartCubit.get(context).expiryDate,
//               cardHolderName: CartCubit.get(context).cardHolderName,
//               cvvCode: CartCubit.get(context).cvvCode,
//               onCreditCardModelChange: (creditCardModel) {
//                 CartCubit.get(context).updateCreditCardDetails(
//                   number: creditCardModel.cardNumber,
//                   expiry: creditCardModel.expiryDate,
//                   holderName: creditCardModel.cardHolderName,
//                   cvv: creditCardModel.cvvCode,
//                   isCvvFocused: creditCardModel.isCvvFocused,
//                 );
//               },
//               formKey: formKey,
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
