// payment_option_tile.dart

import 'package:flutter/material.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';
import 'package:khouyot/generated/l10n.dart';


class AddButton extends StatelessWidget {

  const AddButton({
    super.key, this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 370,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorsManager.grey),
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomSvg(imgPath: AssetsData.add),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
            Text(S.of(context).AddNewcard, style: TextStyles.font16BlackRegular)
        ])
      ),
    );
  }
}
