import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/main.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: AppSize.buttonBorder,
      ),
    );

    Widget buldMenuItemLayout(Locale locale) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 53),
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 11,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 19,
                  width: 19,
                  child: SvgPicture.asset('assets/images/svg/${locale.languageCode}.svg'),
                ),
              ),
            ),
            const SizedBox(width: 9),
            Text(locale.languageCode).tr(),
          ],
        ),
      );
    }

    return DropdownButtonFormField(
      isExpanded: true,
      iconSize: 0,
      items: App.supportedLocales
          .map((Locale locale) => DropdownMenuItem(
                value: locale,
                child: buldMenuItemLayout(locale),
              ))
          .toList(),
      value: Localizations.localeOf(context),
      onChanged: (Locale? locale) async {
        await context.setLocale(locale!);
        await WidgetsBinding.instance.performReassemble();
      },
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border,
        contentPadding: EdgeInsets.zero,
        filled: true,
        fillColor: Theme.of(context).secondaryHeaderColor,
      ),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'SofiaSans',
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
