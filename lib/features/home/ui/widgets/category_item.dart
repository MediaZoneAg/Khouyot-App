import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/image_network.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.isClicked,
    required this.onTap1,
    required this.onTap2,
    required this.product,
  });

  final bool isClicked;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final Data product;

  static const String _fallbackAsset = 'assets/images/no_image_found.jpg';
  static const String _mediaBaseUrl = ''; // e.g. 'https://your-domain.com'

  String? _resolveImageUrl(Data p) {
    final v = (p.variants?.isNotEmpty ?? false)
        ? p.variants!.firstWhere(
            (x) => (x.image ?? '').trim().isNotEmpty,
            orElse: () => Variants(),
          )
        : null;

    String? url = (v?.image ?? '').trim();
    if (url.isEmpty) return null;

    if (!url.startsWith('http')) {
      final sep = (_mediaBaseUrl.endsWith('/') || url.startsWith('/')) ? '' : '/';
      url = '$_mediaBaseUrl$sep$url';
    }
    return url;
  }

  String _safePrice(Data p) {
    if (p.variants != null && p.variants!.isNotEmpty) {
      final price = p.variants!.first.price;
      if (price != null && price.isNotEmpty) return price;
    }
    return p.displayPrice; // fallback to computed display price
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _resolveImageUrl(product);

    Widget imageChild;
    if (imageUrl == null) {
      imageChild = Image.asset(_fallbackAsset, fit: BoxFit.cover);
    } else {
      // If AppCachedNetworkImage supports error handling, expose it; otherwise use Image.network
      imageChild = AppCachedNetworkImage(
        image: imageUrl,
        width: 155.w,
        height: 160.h,
        radius: 10.r,
        fit: BoxFit.cover,
        // If your AppCachedNetworkImage has error/placeholder params, use them.
        // errorWidget: Image.asset(_fallbackAsset, fit: BoxFit.cover),
        // placeholder: (ctx) => Container(color: Colors.black12),
      );
      // If not supported, replace above with:
      // imageChild = Image.network(
      //   imageUrl,
      //   fit: BoxFit.cover,
      //   loadingBuilder: (c, child, progress) =>
      //       progress == null ? child : Container(color: Colors.black12),
      //   errorBuilder: (c, e, s) => Image.asset(_fallbackAsset, fit: BoxFit.cover),
      // );
    }

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final textColor = ThemeCubit.get(context).themeMode == ThemeMode.light
            ? ColorsManager.darkBlack
            : ColorsManager.mainWhite;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Stack(
            children: [
              GestureDetector(
                onTap: onTap1,
                child: SizedBox(
                  width: 150.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: SizedBox(
                          width: 155.w,
                          height: 160.h,
                          child: imageChild,
                        ),
                      ),
                      verticalSpace(5),
                      Text(
                        product.name ?? "Product",
                        style: TextStyles.font16darkBlackRegular.copyWith(color: textColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "EGP ${_safePrice(product)}",
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
                    width: 35.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isClicked ? Icons.favorite : Icons.favorite_border_outlined,
                      color: isClicked ? Colors.red : ColorsManager.darkGrey,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
