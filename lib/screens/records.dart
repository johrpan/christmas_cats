import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../localizations.dart';
import '../storage.dart';
import '../widgets/menu.dart';
import '../widgets/menu_entry.dart';

class RecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = ChristmasCatsLocalizations.of(context);

    return Scaffold(
      body: Menu(
        title: localizations.records,
        children: <Widget>[
          MenuEntry(
            text: sprintf(localizations.records1, [storage.highScore1]),
          ),
          MenuEntry(
            text: sprintf(localizations.records2, [storage.highScore2]),
          ),
          MenuEntry(
            text: sprintf(localizations.records3, [storage.highScore3]),
          ),
        ],
        showBackButton: true,
      ),
    );
  }
}
