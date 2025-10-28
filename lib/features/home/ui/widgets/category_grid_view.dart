
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/home/ui/widgets/category_grid_view_all.dart';
import 'package:khouyot/features/home/ui/widgets/category_grid_view_current.dart';

class CategoryGridView extends StatefulWidget {
  const CategoryGridView({super.key});

  @override
  State<CategoryGridView> createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return HomeCubit.get(context).currentCategory == "All"
            ? const CategoryGridViewAll()
            : const CategoryGridViewCurrent();
      },
    );
  }
}
