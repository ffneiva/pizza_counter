import 'package:flutter/material.dart';
import 'package:pizza_counter/src/pizza_counter/pizza_counter_controller.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController();
  final pizzaCounterController = PizzaCounterController();

  await settingsController.loadSettings();
  await pizzaCounterController.loadPizzaCounter();

  runApp(MyApp(settingsController: settingsController));
}
