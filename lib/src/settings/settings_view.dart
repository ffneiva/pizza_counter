import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pizza_counter/src/settings/settings_controller.dart';
import 'package:pizza_counter/src/widgets/pizza_scaffold.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({
    super.key,
  });

  static const routeName = '/settings';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;

    return PizzaScaffold(
      title: locale.settingsTitle,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                _configOption(
                  context,
                  locale.settingsTheme,
                  DropdownButton<ThemeMode>(
                    value: settingsController.themeMode,
                    isExpanded: true,
                    onChanged: (t) {
                      settingsController.updateThemeMode(t);
                      setState(() {});
                    },
                    items: [
                      DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text(locale.settingsSystemTheme)),
                      DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text(locale.settingsLightTheme)),
                      DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text(locale.settingsDarkTheme)),
                    ],
                  ),
                ),
                _configOption(
                  context,
                  locale.settingsLanguage,
                  DropdownButton(
                    value: settingsController.language,
                    isExpanded: true,
                    onChanged: (l) {
                      settingsController.updateLanguageMode(l);
                      setState(() {});
                    },
                    items: [
                      _dropdownMenuItemLocation(
                          'pt', FlagsCode.BR, locale.settingsPortuguese),
                      _dropdownMenuItemLocation(
                          'en', FlagsCode.US, locale.settingsEnglish),
                      _dropdownMenuItemLocation(
                          'es', FlagsCode.ES, locale.settingsSpanish),
                    ],
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget _configOption(BuildContext context, String title, Widget widget) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5 - 16,
            child: Text(title, style: const TextStyle(fontSize: 16)),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5 - 16,
            child: widget,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem _dropdownMenuItemLocation(
      String value, FlagsCode flag, String description) {
    return DropdownMenuItem(
      value: value,
      child: Row(
        children: [
          Flag.fromCode(flag, height: 16, width: 24),
          const SizedBox(width: 8),
          Text(description),
        ],
      ),
    );
  }
}
