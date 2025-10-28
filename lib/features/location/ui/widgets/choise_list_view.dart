
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/location/logic/location_cubit.dart';
import 'package:khouyot/features/location/ui/widgets/choise_location_item.dart';

class ChoiseListView extends StatelessWidget {
  const ChoiseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                height: 70,
                child: BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: LocationCubit.get(context).locations.length,
                      itemBuilder: (context, index) {
                        return ChoiseLocationItem(
                          title: LocationCubit.get(context).locations[index],
                          isSelected: LocationCubit.get(context).currentPageIndex == index,
                          onTap: () {
                            LocationCubit.get(context).changeCurrentIndex(index);
                          },
                        );
                      },
                    );
                  },
                ),
              );
  }
}