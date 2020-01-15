import 'package:flutter/material.dart';

import '../localizations.dart';

import 'menu_entry.dart';

class Menu extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final bool showBackButton;

  Menu({
    this.title,
    this.subtitle,
    this.children,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = ChristmasCatsLocalizations.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (title != null)
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 64.0,
            ),
          ),
        if (subtitle != null)
          Text(
            subtitle,
            style: TextStyle(fontSize: 32.0),
          ),
        SizedBox(
          height: 16.0,
        ),
        ...?children,
        if (showBackButton) ...[
          SizedBox(
            height: 32.0,
          ),
          MenuEntry(
            text: localizations.back,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ],
    );
  }
}
