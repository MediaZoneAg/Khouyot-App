
import 'package:flutter/cupertino.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/styles.dart';

class MaterialItem extends StatelessWidget {
  const MaterialItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('MATERIALS', style: TextStyles.font16BlackRegular),
                verticalSpace(5),
                Text('Fabric:                  High Stretch',
                    style: TextStyles.font14BlackRegular),
                verticalSpace(3),
                Text('Fit Type:               High Stretch',
                    style: TextStyles.font14BlackRegular),
                verticalSpace(3),
                Text('Sheer:                   No',
                    style: TextStyles.font14BlackRegular),
                verticalSpace(3),
                Text('Composition:      94% cotton,6% Elastane',
                    style: TextStyles.font14BlackRegular),
                verticalSpace(25),
      ],
    );
  }
}