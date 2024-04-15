import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pizza_counter/src/pizza_counter/pizza_counter_controller.dart';
import 'package:pizza_counter/src/widgets/add_person.dart';
import 'package:pizza_counter/src/widgets/confirm_dialog.dart';

class PizzaCounterGroup extends StatefulWidget {
  final PizzaCounterController pizzaCounterController;

  const PizzaCounterGroup({
    super.key,
    required this.pizzaCounterController,
  });

  @override
  State<PizzaCounterGroup> createState() => _PizzaCounterGroupState();
}

class _PizzaCounterGroupState extends State<PizzaCounterGroup>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
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
    double padding = 16;
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    List<int> groupCounter = widget.pizzaCounterController.groupCounter;
    List<String> groupName = widget.pizzaCounterController.groupName;
    AppLocalizations locale = AppLocalizations.of(context)!;

    if (groupCounter.isNotEmpty) {
      return ListView.builder(
        padding: EdgeInsets.all(padding),
        itemCount: groupCounter.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                onTap: () => _countPizza(index),
                onLongPress: () {
                  widget.pizzaCounterController.groupRemoveCounter(index);
                  setState(() {});
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: Theme.of(context).hintColor),
                ),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/images/logo.png'),
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).canvasColor.withOpacity(0.3),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        groupCounter[index].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(groupName[index]),
                ),
                trailing: SizedBox(
                  width: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => addPerson(
                          context,
                          (name) {
                            widget.pizzaCounterController
                                .editPerson(index, name!);
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          name: groupName[index],
                        ),
                        child: const Icon(Icons.edit_rounded),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.pizzaCounterController
                              .groupClearCounter(index);
                          setState(() {});
                        },
                        child: const Icon(Icons.cleaning_services_rounded),
                      ),
                      GestureDetector(
                        onTap: () => confirmDialog(
                          context,
                          locale.pizzaRemovePerson,
                          () {
                            widget.pizzaCounterController.removePerson(index);
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                        ),
                        child: const Icon(Icons.delete_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              if (index < groupCounter.length - 1) const SizedBox(height: 10),
            ],
          );
        },
      );
    } else {
      return Container(
        padding: EdgeInsets.all(padding),
        child: Opacity(
          opacity: 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_rounded,
                size: math.min(width, height) * 0.5,
              ),
              Text(
                locale.pizzaEmptyGroup,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _animate(int index) {
    animationController.reset();
    animationController.status == AnimationStatus.forward
        ? animationController.stop()
        : animationController.forward();
  }

  void _countPizza(int index) {
    _animate(index);
    widget.pizzaCounterController.groupAddCounter(index);
    setState(() {});
  }
}
