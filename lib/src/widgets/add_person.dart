import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void addPerson(BuildContext context, Function onTap, {String? name}) {
  bool editing = true;
  if (name == null || name.isEmpty) {
    name = '';
    editing = false;
  }
  AppLocalizations locale = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(editing ? locale.pizzaEditPerson : locale.pizzaAddPerson),
        content: TextField(
          controller: TextEditingController(text: name),
          maxLength: 25,
          onChanged: (value) => name = value,
          autofocus: true,
          buildCounter: (BuildContext context,
              {required int currentLength,
              required bool isFocused,
              required int? maxLength}) {
            return const SizedBox.shrink();
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              locale.closeButton,
              style: const TextStyle(color: Color.fromARGB(255, 211, 47, 47)),
            ),
          ),
          TextButton(
            onPressed: () => onTap(name),
            child: Text(
              locale.confirmButton,
              style: const TextStyle(color: Color.fromARGB(255, 255, 160, 0)),
            ),
          ),
        ],
      );
    },
  );
}
