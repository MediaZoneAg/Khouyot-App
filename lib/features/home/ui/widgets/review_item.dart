
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theming/styles.dart';

class ReviewItem extends StatelessWidget {
  final String personImage;
  final String title;
  final String text;
  final String time;
  const ReviewItem(
      {super.key,
      required this.personImage,
      required this.title,
      required this.time, required this.text,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(personImage),
          ),
          title: Text(title, style: TextStyles.font16BlackRegular),
          subtitle: Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 17.sp),
              Icon(Icons.star, color: Colors.amber, size: 17.sp),
              Icon(Icons.star, color: Colors.amber, size: 17.sp),
              Icon(Icons.star, color: Colors.amber, size: 17.sp),
              Icon(Icons.star_border_outlined, size: 17.sp),
            ],
          ),
          trailing: Text(time, style: TextStyles.font14DarkGreyRegular),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 90.0),
          child: Text(text, style: TextStyles.font14BlackRegular),
        ),
      ],
    );
  }
}
