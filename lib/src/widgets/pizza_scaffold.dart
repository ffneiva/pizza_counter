import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pizza_counter/src/settings/settings_controller.dart';
import 'package:pizza_counter/src/widgets/pizza_drawer.dart';

class PizzaScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Function? onBack;

  const PizzaScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.onBack,
  });

  @override
  State<PizzaScaffold> createState() => _PizzaScaffoldStateState();
}

class _PizzaScaffoldStateState extends State<PizzaScaffold> {
  late final GlobalKey<ScaffoldState> _scaffoldState;
  final SettingsController settingsController = SettingsController();

  @override
  void initState() {
    super.initState();
    _scaffoldState = GlobalKey<ScaffoldState>();
    BackButtonInterceptor.add(_onWillPop);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_onWillPop);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: FittedBox(fit: BoxFit.scaleDown, child: Text(widget.title)),
        backgroundColor: const Color.fromARGB(255, 255, 160, 0),
        foregroundColor: Colors.white,
        actions: widget.actions,
      ),
      drawer: PizzaDrawer(scaffoldState: _scaffoldState),
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  bool _onWillPop(bool stopDefaultButtonEvent, RouteInfo info) {
    BuildContext context = _scaffoldState.currentContext!;
    if (!Navigator.of(context).canPop()) {
      _showBackDialog(context);
      return true;
    }
    return false;
  }

  Future<void> _showBackDialog(BuildContext context) async {
    AppLocalizations locale = AppLocalizations.of(context)!;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(locale.confirmExit),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                locale.backButton,
                style: const TextStyle(color: Color.fromARGB(255, 255, 162, 0)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pop(context);
              },
              child: Text(
                locale.confirmButton,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
