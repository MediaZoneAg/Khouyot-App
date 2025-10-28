
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/models/category_model.dart';
import 'package:khouyot/core/widgets/app_category_app_bar.dart';
import 'package:khouyot/generated/l10n.dart';

class CategoryItemScreen extends StatelessWidget {
  const CategoryItemScreen({super.key, required this.categoryModel});
    final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CategoryAppBar(title: S.of(context).back, content: const Icon(Icons.arrow_back_ios), width: 10.w,),
          ],
        ),
      ),
    );
  }
}