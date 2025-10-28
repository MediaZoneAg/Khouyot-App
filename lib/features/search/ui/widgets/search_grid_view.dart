import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/khouyot.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/functions/snak_bar.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/favorite/logic/cubit/fav_cubit.dart';
import 'package:khouyot/features/search/logic/search_cubit.dart';
import 'package:khouyot/features/search/ui/widgets/search_item.dart';
import 'package:khouyot/features/search/ui/widgets/ui_search_loading.dart';
import 'package:khouyot/generated/l10n.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchGridView extends StatefulWidget {
  const SearchGridView({super.key});

  @override
  State<SearchGridView> createState() => _SearchGridViewState();
}

class _SearchGridViewState extends State<SearchGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        return BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return const Skeletonizer(
                enabled: true,
                child: UiLoadingSearch(),
              );
            }
            if (SearchCubit.get(context).searchResults.isNotEmpty) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0.w,
                  //  childAspectRatio: 0.76,
                  mainAxisExtent: 300.h,
                ),
                itemCount: SearchCubit.get(context).searchResults.length,
                itemBuilder: (context, index) {
                  return SearchResultItem(
                    productModel: SearchCubit.get(context).searchResults[index],
                    onTap1: () {
                      context.pushNamed(Routes.categoryDetails,
                          arguments:
                              SearchCubit.get(context).searchResults[index]);
                    },
                    onTap2: () async {
                      await favFunction(index,
                          SearchCubit.get(context).searchResults[index].data?.first.id ?? 0);
                    },
                    isClicked: FavCubit.get(context).favorite.contains(
                        SearchCubit.get(context).searchResults[index].data?.first.id ?? 0),
                  );
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: Lottie.asset(AssetsData.notFound),
              );
            }
          },
        );
      },
    );
  }

  Future<void> favFunction(int index, int productId) async {
    final favCubit = FavCubit.get(context);
    if (await CashHelper.getStringSecured(key: Keys.token) != "") {
      if (favCubit.favorite.contains(productId)) {
        favCubit.removeFromWishList(
  model: SearchCubit.get(context).searchResults[index].convertToFav(),
).then((value) => favCubit.getWishList());


      } else {
        favCubit
            .addToWishList(model: SearchCubit.get(context).searchResults[index])
            .then((value) => favCubit.getWishList());
      }
    } else {
      showSnackBar(
        context: NavigationService.navigatorKey.currentState!.context,
        text: S.of(context).YouNeedToLoginFirst,
      );
    }
  }
}
