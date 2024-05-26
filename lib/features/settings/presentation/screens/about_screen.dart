import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/tags/styled_text_tag_action.dart';
import 'package:styled_text/widgets/styled_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/core/util/logger.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';
import 'package:who_boogles_it/shared/presentation/screens/scaffold_wrapper.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultText = Theme.of(context).textTheme.bodySmall!;
    final TextStyle markedText = defaultText.copyWith(color: AppColor.colorScheme.primary);
    final TextStyle linkText = defaultText.copyWith(
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.bold,
    );

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
                child: CircleAvatar(
                  radius: AppSize.profileAvatarSize / 2,
                  backgroundColor: AppColor.pageColor,
                  child: const CircleAvatar(
                    radius: AppSize.profileAvatarSize / 2 - 3,
                    backgroundImage: AssetImage("assets/images/png/foto_512.png"),
                  ).animate().shimmer(
                        delay: 800.ms,
                      ),
                ),
              ).animate().scale(
                    delay: 400.ms,
                    curve: Curves.fastOutSlowIn,
                  ),
              const SizedBox(height: AppSize.defaultSpace),
              for (var i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSize.defaultSpace),
                  child: StyledText(
                    text: 'about_$i'.tr(),
                    style: defaultText,
                    tags: {
                      'mark': StyledTextTag(style: markedText),
                      'tg': StyledTextActionTag(
                        (text, attrs) => onTgPressed(),
                        style: linkText,
                      ),
                    },
                  ),
                )
                    .animate()
                    .slideX(
                      delay: Duration(milliseconds: 600 + i * 200),
                      duration: 400.ms,
                      begin: 0.1,
                      end: 0,
                      curve: Curves.fastOutSlowIn,
                    )
                    .fadeIn(
                      delay: Duration(milliseconds: 600 + i * 200),
                      duration: 400.ms,
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
                  delay: 1400.ms,
                  curve: Curves.fastOutSlowIn,
                ),
          ),
        ],
      ),
    );
  }

  Future<void> onTgPressed() async {
    var url = Uri.parse("https://t.me/coder1cv8");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Logger.print('Could not launch $url', level: 'ERROR');
    }
  }
}
