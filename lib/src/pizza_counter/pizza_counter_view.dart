import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pizza_counter/src/pizza_counter/pizza_counter_controller.dart';
import 'package:pizza_counter/src/pizza_counter/components/pizza_counter_group.dart';
import 'package:pizza_counter/src/pizza_counter/components/pizza_counter_person.dart';
import 'package:pizza_counter/src/settings/settings_controller.dart';
import 'package:pizza_counter/src/widgets/add_person.dart';
import 'package:pizza_counter/src/widgets/pizza_scaffold.dart';

class PizzaCounterView extends StatefulWidget {
  const PizzaCounterView({
    super.key,
  });

  static const routeName = '/pizza_counter';

  @override
  State<PizzaCounterView> createState() => _PizzaCounterViewState();
}

class _PizzaCounterViewState extends State<PizzaCounterView>
    with SingleTickerProviderStateMixin {
  late bool group;
  late AnimationController animationController;
  final SettingsController settingsController = SettingsController();
  final PizzaCounterController pizzaCounterController =
      PizzaCounterController();

  @override
  void initState() {
    super.initState();
    group = false;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    AppLocalizations locale = AppLocalizations.of(context)!;

    return PizzaScaffold(
      title: locale.pizzaTitle,
      actions: [
        IconButton(
          onPressed: () => showHelp(context),
          icon: const Icon(Icons.help_outlined),
        ),
      ],
      body: (width >= height)
          ? Row(children: _getContent())
          : Column(children: _getContent()),
      floatingActionButton: group
          ? FloatingActionButton(
              onPressed: () => addPerson(context, (name) {
                pizzaCounterController.addPerson(name!);
                Navigator.of(context).pop();
                setState(() {});
              }),
              backgroundColor: const Color.fromARGB(255, 255, 160, 0),
              child: Icon(
                Icons.person_add,
                color: Theme.of(context).cardColor,
              ),
            )
          : const SizedBox(),
    );
  }

  List<Widget> _getContent() {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return [
      Container(
        padding: const EdgeInsets.all(16),
        height: (width >= height) ? height : 80,
        width: (width >= height) ? 150 : width,
        child: (width >= height)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _getSupportContent(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _getSupportContent(),
              ),
      ),
      Flexible(
        fit: FlexFit.tight,
        child: group
            ? PizzaCounterGroup(
                pizzaCounterController: pizzaCounterController,
              )
            : PizzaCounterPerson(
                pizzaCounterController: pizzaCounterController,
              ),
      ),
    ];
  }

  List<Widget> _getSupportContent() {
    AppLocalizations locale = AppLocalizations.of(context)!;

    return [
      ElevatedButton(
        onPressed: () => setState(() => group
            ? pizzaCounterController.groupRemoveLastCounter()
            : pizzaCounterController.personRemoveCounter()),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(8),
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 255, 160, 0),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: 70,
          child: Text(
            locale.removeButton,
            style: TextStyle(color: Theme.of(context).canvasColor),
          ),
        ),
      ),
      ElevatedButton(
        onPressed: () => setState(() => group
            ? pizzaCounterController.groupClearAllCounter()
            : pizzaCounterController.personClearCounter()),
        style: const ButtonStyle(
          elevation: MaterialStatePropertyAll(8),
          backgroundColor: MaterialStatePropertyAll(
            Color.fromARGB(255, 211, 47, 47),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: 70,
          child: Text(
            locale.cleanButton,
            style: TextStyle(color: Theme.of(context).canvasColor),
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        width: 100,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            children: [
              Text(locale.pizzaGroup),
              Switch(
                value: group,
                onChanged: (bool value) => setState(() => group = value),
                activeColor: const Color.fromARGB(255, 255, 160, 0),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  void showHelp(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  locale.closeButton,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 255, 160, 0)),
                ),
              ),
            ],
          );
        });
  }

  void animate() {
    animationController.reset();
    animationController.status == AnimationStatus.forward
        ? animationController.stop()
        : animationController.forward();
  }
}
