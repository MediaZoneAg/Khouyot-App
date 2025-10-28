
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/widgets/image_network.dart';

class TotalImageScreen extends StatelessWidget {
  const TotalImageScreen({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.7),
        body: Center(
          child: Hero(
            tag: 'imageHero',
            child:AppCachedNetworkImage(
                height: 270.h,
                width: 270.w,
                image: image,
                fit: BoxFit.fill,
              ),
          ),
        ),
      ),
    );
  }
  }
