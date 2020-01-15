import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../localizations.dart';
import '../widgets/menu.dart';
import '../widgets/menu_entry.dart';

class PauseScreen extends StatelessWidget {
  final int score;

  PauseScreen({
    this.score,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = ChristmasCatsLocalizations.of(context);

    return Scaffold(
      backgroundColor: Color(0xccffffff),
      body: Menu(
        title: localizations.paused,
        subtitle: sprintf(localizations.score, [score]),
        children: <Widget>[
          MenuEntry(
            text: localizations.unpause,
            onTap: () => Navigator.pop(context, true),
          ),
          MenuEntry(
            text: localizations.exit,
            onTap: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
  }
}
