import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/favorite/logic/cubit/fav_cubit.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/home/ui/widgets/features_list_view.dart';
import 'package:khouyot/features/home/ui/widgets/search_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 @override
void initState() {
  super.initState();
   WidgetsBinding.instance.addPostFrameCallback((_) {
    // Load categories and initial products
    context.read<CategoryCubit>().fetchCategories();
    context.read<HomeCubit>().fetchAllProducts();
    FavCubit.get(context).getWishList();
   
  // Fetch categories first
  CategoryCubit.get(context).fetchCategories().then((value) {
    // Initialize categories map with empty lists
    final categoryCubit = CategoryCubit.get(context);
    for (var category in categoryCubit.topLevelCategories) {
      if (!HomeCubit.get(context)
          .categoriesMap
          .containsKey(category.slug.toString())) {
        HomeCubit.get(context).categoriesMap[category.slug.toString()] = [];
      }
    }
   });});
  
  // Then fetch all products
  // HomeCubit.get(context)
  //     .fetchAllProducts()
  //     .then((value) => FavCubit.get(context).getWishList());
}
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          color: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          child: SafeArea(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.0.h),
              child: RefreshIndicator(
                onRefresh: () async {
                  if (HomeCubit.get(context).currentCategory != "All") {
                    int currentid = 0;
                    CategoryCubit.get(context).categories.forEach((element) {
                      if (element.data?.first.slug.toString() ==
                          HomeCubit.get(context).currentCategory) {
                        currentid = element.data!.first.id!;
                      }
                    });
                    await HomeCubit.get(context)
                        .fetchProductAtSpecificCategories(
                            currentid, HomeCubit.get(context).currentCategory,
                            getOnlyFormNetwork: true);
                  }
                  await HomeCubit.get(context)
                      .fetchAllProducts(getOnlyFormNetwork: true);
                  FavCubit.get(context).getWishList();
                },
                child: Column(
                  children: [
                    const SearchItem(),
                    verticalSpace(12),
                    const Expanded(
                      child: FeaturesListView(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
