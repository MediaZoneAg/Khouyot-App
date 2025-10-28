import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';

class UiLoadingProfile extends StatelessWidget {
  const UiLoadingProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorsManager.grey)),
      child: ListTile(
        leading: CircleAvatar(
            radius: 30.r,
            backgroundImage: const AssetImage(AssetsData.profileImage)),
        title: Text("test", style: TextStyles.font16BlackRegular),
        subtitle:
            Text('test@gmail.com', style: TextStyles.font16DarkgreyRegular),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
        onTap: () {},
      ),
    );
  }
}
