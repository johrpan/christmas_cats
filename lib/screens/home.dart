import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../localizations.dart';
import '../widgets/menu.dart';
import '../widgets/menu_entry.dart';

import 'game.dart';
import 'intro.dart';
import 'records.dart';
import 'shop.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = ChristmasCatsLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Menu(
        title: localizations.title,
        subtitle: localizations.dedication,
        children: <Widget>[
          MenuEntry(
            text: localizations.play,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameScreen(),
              ),
            ),
          ),
          MenuEntry(
            text: localizations.records,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecordsScreen(),
              ),
            ),
          ),
          MenuEntry(
            text: localizations.intro,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IntroScreen(),
              ),
            ),
          ),
          Builder(
            builder: (context) => MenuEntry(
              text: localizations.shop,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopScreen(),
                ),
              ),
            ),
          ),
          MenuEntry(
            text: localizations.exit,
            onTap: () => SystemNavigator.pop(),
          ),
        ],
      ),
    );
  }
}
