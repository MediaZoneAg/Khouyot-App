import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/di/Dependency_inj.dart';
import 'package:khouyot/core/models/category_model.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/features/auth/ui/screens/enterance_screen.dart';
import 'package:khouyot/features/auth/ui/screens/forgot_password_screen.dart';
import 'package:khouyot/features/auth/ui/screens/reset_password_screen.dart';
import 'package:khouyot/features/auth/ui/screens/signin_screen.dart';
import 'package:khouyot/features/auth/ui/screens/signup_screen.dart';
import 'package:khouyot/features/auth/ui/screens/verify_code_screen.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/cart/ui/screens/checkout_screen.dart';
import 'package:khouyot/features/cart/ui/screens/paymob_screen.dart';
import 'package:khouyot/features/cart/ui/screens/peyment_details_screen.dart';
import 'package:khouyot/features/cart/ui/screens/thank_you_screen.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/category/ui/screens/category_item_screen.dart';
import 'package:khouyot/features/category/ui/screens/product_screen.dart';
import 'package:khouyot/features/favorite/logic/cubit/fav_cubit.dart';
import 'package:khouyot/features/favorite/ui/screens/wish_list_screen.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/home/ui/screens/category_details_screen.dart';
import 'package:khouyot/features/location/logic/location_cubit.dart';
import 'package:khouyot/features/location/ui/screens/choose_location_options_screen.dart';
import 'package:khouyot/features/location/ui/screens/location_manual_screen.dart';
import 'package:khouyot/features/nav_bar/ui/navigationbar.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/features/profile/ui/screens/change_password_screen.dart';
import 'package:khouyot/features/profile/ui/screens/chat_screen.dart';
import 'package:khouyot/features/profile/ui/screens/delete_account_screen.dart';
import 'package:khouyot/features/profile/ui/screens/edit_account_info_screen.dart';
import 'package:khouyot/features/profile/ui/screens/notification_screen.dart';
import 'package:khouyot/features/profile/ui/screens/orders_screen.dart';
import 'package:khouyot/features/profile/ui/screens/profile_details_screen.dart';
import 'package:khouyot/features/profile/ui/screens/saved_address_screen.dart';
import 'package:khouyot/features/profile/ui/screens/setting_screen.dart';
import 'package:khouyot/features/rewards/ui/screen/rewards_screen.dart';
import 'package:khouyot/features/search/logic/search_cubit.dart';
import 'package:khouyot/features/search/ui/screens/filter_results.dart';
import 'package:khouyot/features/search/ui/screens/filter_screen.dart';
import 'package:khouyot/features/search/ui/screens/search_results.dart';
import 'package:khouyot/features/search/ui/screens/search_screen.dart';
import 'package:khouyot/features/splash/ui/screens/logic/cubit/splash_cubit.dart';
import 'package:khouyot/features/splash/ui/screens/splash_screen.dart';

import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )

    switch (settings.name) {
      case Routes.splashScreen:
       return MaterialPageRoute(
          builder: (_) =>  BlocProvider(
  create: (context) => getIt<SplashCubit>(),
  child: const SplashScreen(),
  
),);
      case Routes.enteranceScreen:
        return MaterialPageRoute(
          builder: (_) => const EnteranceScreen(),
        );
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const SignInScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const SignUpScreen(),
          ),
        );
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const ForgotPasswordScreen(),
          ),
        );
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const ResetPasswordScreen(),
          ),
        );
      case Routes.verifyCode:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const VerifyCode(),
          ),
        );
      case Routes.navigationBar:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    // BlocProvider.value(
                    //   value: getIt<NavBarCubit>(),
                    // ),
                    BlocProvider(
                      create: (context) => getIt<CartCubit>(),
                    ),
                  ],
                  child: const NavigationBarApp(),
                ));
      case Routes.categoryDetails:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: getIt<HomeCubit>(),
                    ),
                    BlocProvider.value(
                      value: getIt<FavCubit>(),
                    ),
                    BlocProvider.value(
                      value: getIt<CartCubit>(),
                    )
                  ],
                  child: CategoryDetails(
                      productModel: settings.arguments as ProductModel),
                ));
      case Routes.categoryItemScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: getIt<CategoryCubit>(),
                  child: CategoryItemScreen(
                      categoryModel: settings.arguments as CategoryModel),
                ));
      case Routes.profileDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<ProfileCubit>(),
            child: const ProfileDetailsScreen(),
          ),
        );
      case Routes.editAccountInfoScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<ProfileCubit>(),
            child: const EditAccountInfoScreen(),
          ),
        );
      case Routes.settingScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<ProfileCubit>(),
              ),
              // BlocProvider.value(
              //   value: NavBarCubit(),
              // ),
            ],
            child: const SettingScreen(),
          ),
        );
      case Routes.savedAddressScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<ProfileCubit>(),
            child: const SavedAddressScreen(),
          ),
        );
      case Routes.notificationScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<ProfileCubit>(),
            child: const NotificationScreen(),
          ),
        );
      case Routes.ordersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<ProfileCubit>(),
            child: const OrdersScreen(),
          ),
        );
      case Routes.wishListScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<FavCubit>(),
            child: const WishListScreen(),
          ),
        );
      case Routes.changePasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<ProfileCubit>(),
            child: const ChangePasswordScreen(),
          ),
        );
      case Routes.deleteAccountScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<ProfileCubit>(),
            child: const DeleteAccountScreen(),
          ),
        );
      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<SearchCubit>(),
            child: const SearchScreen(),
          ),
        );
      case Routes.searchResults:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<SearchCubit>(),
              ),
              BlocProvider.value(
                value: getIt<FavCubit>(),
              ),
              BlocProvider.value(
                value: getIt<CategoryCubit>(),
              ),
            ],
            child: const SearchResults(),
          ),
        );
      case Routes.filterResults:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<SearchCubit>(),
            child: const FilterResults(),
          ),
        );
      case Routes.filterScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<SearchCubit>(),
              ),
              BlocProvider.value(
                value: getIt<CategoryCubit>(),
              ),
            ],
            child: const FilterScreen(),
          ),
        );
      case Routes.chooseLocationOptionsScreen:
        return MaterialPageRoute(
          builder: (_) => const ChooseLocationOptionsScreen(),
        );
      case Routes.locationManualScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LocationCubit(),
              ),
              BlocProvider.value(
                value: getIt<CartCubit>(),
              ),
            ],
            child: const LocationManualScreen(),
          ),
        );
      case Routes.checkOutScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<CartCubit>(),
            child: const CheckOutScreen(),
          ),
        );
      case Routes.productScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<CategoryCubit>(),
              ),
              BlocProvider.value(
                value: getIt<FavCubit>(),
              ),
            ],
            child: const ProductScreen(),
          ),
        );
      case Routes.thankYouScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<CartCubit>(),
            child: const ThankYouScreen(),
          ),
        );
      case Routes.peymentDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<CartCubit>(),
            child: const PaymentDetailsScreen(),
          ),
        );
        case Routes.payMobScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<CartCubit>(),
            child: const PayMobScreen(),
          ),
        );
      case Routes.rewardsScreen:
        return MaterialPageRoute(builder: (_) => const RewardsScreen());
         case Routes.chatScreen:
        return MaterialPageRoute(builder: (_) =>  WebViewChat());
    }
    return null;
  }
}
