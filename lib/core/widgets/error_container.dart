
import 'package:flutter/material.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/profile/ui/widgets/profile_items_list_tile.dart';
import 'package:khouyot/generated/l10n.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.red
        )
      ),
      child:  ProfileItemListTile(
        title:title ?? S.of(context).sorry,
        img: AssetsData.error,
        color: Colors.red,
      ),
    );
  }
}
