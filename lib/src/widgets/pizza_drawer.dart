import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pizza_counter/src/pizza_counter/pizza_counter_view.dart';
import 'package:pizza_counter/src/settings/settings_view.dart';
import 'package:pizza_counter/src/utils/functions.dart';
import 'package:url_launcher/url_launcher.dart';

class PizzaDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldState;

  const PizzaDrawer({
    super.key,
    required this.scaffoldState,
  });

  @override
  State<PizzaDrawer> createState() => _PizzaDrawerState();
}

class _PizzaDrawerState extends State<PizzaDrawer> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _drawerHeader(locale),
                _listTileItem(Icons.local_pizza, locale.pizzaPage,
                    const PizzaCounterView()),
                // _listTileItem(
                //     Icons.history, locale.historicPage, const HistoricView()),
                _listTileItem(
                    Icons.settings, locale.settingsPage, const SettingsView()),
                // _listTileItem(
                //     Icons.info_outline, locale.aboutPage, const AboutView()),
              ],
            ),
          ),
          _copyright(),
        ],
      ),
    );
  }

  Widget _drawerHeader(AppLocalizations locale) {
    return DrawerHeader(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 160, 0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 50,
            child: Image.asset('assets/images/logo.png'),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              locale.appTitle,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTileItem(IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).popUntil((route) => route.isFirst);
        if (page.toString() != const PizzaCounterView().toString()) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
    );
  }

  Widget _copyright() {
    return ListTile(
      title: Center(
        child: Text(getCopyright(), style: const TextStyle(fontSize: 12)),
      ),
      onTap: () => launchUrl(Uri.parse(getCopyrightLink())),
    );
  }
}
