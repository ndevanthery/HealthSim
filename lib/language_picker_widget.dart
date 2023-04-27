import 'package:flutter/material.dart';
import 'package:healthsim/l10n/l10n.dart';
import 'package:healthsim/locale_provider.dart';
import 'package:provider/provider.dart';

//put the language
class LanguagePickerWidget extends StatelessWidget {
  const LanguagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: currentLocale,
        icon: Container(width: 10),
        items: L10n.all.map((locale) {
          final flag = L10n.getFlag(locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            onTap: () {
              final provider =
                  Provider.of<LocaleProvider>(context, listen: false);
              provider.setLocale(locale);
            },
            child: Center(
              child: Text(
                flag,
                style: const TextStyle(
                    fontSize: 15, color: Color.fromRGBO(144, 202, 249, 1)),
              ),
            ),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
