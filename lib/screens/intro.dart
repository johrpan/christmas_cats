import 'package:flutter/material.dart';

import '../localizations.dart';
import '../widgets/menu.dart';
import '../widgets/menu_entry.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = ChristmasCatsLocalizations.of(context);

    return Scaffold(
      body: Menu(
        title: localizations.intro,
        children: <Widget>[
          MenuEntry(
            text: localizations.poem,
          ),
        ],
        showBackButton: true,
      ),
    );
  }
}
