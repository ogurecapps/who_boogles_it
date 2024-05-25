import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';
import 'package:who_boogles_it/shared/presentation/screens/scaffold_wrapper.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      resizeToAvoidBottomInset: false,
      background: AppColor.colorScheme.surface,
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [AppTheme.defaultBoxShadow],
                ),
                child: const CircleAvatar(
                  radius: AppSize.profileAvatarSize / 2,
                  backgroundColor: AppColor.pageColor,
                  child: CircleAvatar(
                    radius: AppSize.profileAvatarSize / 2 - 3,
                    backgroundImage: AssetImage("assets/images/png/foto_512.png"),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.defaultSpace),
              for (var i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSize.defaultSpace),
                  child: Text('about_$i', style: Theme.of(context).textTheme.bodySmall).tr(),
                ),
            ]),
          )),
          const SizedBox(height: AppSize.defaultSpace),
          SizedBox(
            width: AppSize.menuButtonWidth,
            child: ElevatedButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios),
              label: const Text(LocaleKeys.back).tr(),
            ).animate().flip(
                  delay: 400.ms,
                  curve: Curves.fastOutSlowIn,
                ),
          ),
        ],
      ),
    );
  }
}
