import 'package:flutter/material.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/as_guest_container.dart';
import 'package:khouyot/features/profile/ui/widgets/language_list_tile.dart';
import 'package:khouyot/features/profile/ui/widgets/profile_items_list_tile.dart';
import 'package:khouyot/generated/l10n.dart';

class ProfileGuestScreen extends StatelessWidget {
  const ProfileGuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AsGuestContainer(),
              verticalSpace(20),
              //Text('Settings', style: TextStyles.font20BlackMedium),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsManager.grey),
                ),
                child: Column(
                  children: [
                    LanguageListTile(),
                    // const Divider(),
                    // const CountrylistTile(),
                  ],
                ),
              ),
              verticalSpace(20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsManager.grey),
                ),
                child: Column(
                  children: [
                    ProfileItemListTile(
                      title: S.of(context).GetHelp,
                      onTap: () {},
                      img: AssetsData.getHelp,
                    ),
                    const Divider(),
                    ProfileItemListTile(
                      title: S.of(context).TermsConditions,
                      onTap: () {},
                      img: AssetsData.termsConditions,
                    ),
                    const Divider(),
                    ProfileItemListTile(
                      title: S.of(context).PrivacyPolicy,
                      onTap: () {},
                      img: AssetsData.privacyPolicy,
                    ),
                    const Divider(),
                    ProfileItemListTile(
                      title: S.of(context).AboutApp,
                      onTap: () {},
                      img: AssetsData.aboutApp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
