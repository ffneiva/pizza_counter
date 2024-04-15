import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void confirmDialog(BuildContext context, String title, Function onPressed) {
  AppLocalizations locale = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              locale.closeButton,
              style: const TextStyle(color: Color.fromARGB(255, 255, 160, 0)),
            ),
          ),
          TextButton(
            onPressed: () => onPressed(),
            child: Text(
              locale.confirmButton,
              style: const TextStyle(color: Color.fromARGB(255, 211, 47, 47)),
            ),
          ),
        ],
      );
    },
  );
}
