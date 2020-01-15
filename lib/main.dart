import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/home.dart';

import 'localizations.dart';
import 'storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final util = Util();

  await util.setPortrait();
  await util.fullScreen();

  await storage.init();

  runApp(MaterialApp(
    color: Colors.white,
    theme: ThemeData(
      primarySwatch: Colors.grey,
      fontFamily: 'Tangerine',
    ),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      ChristmasCatsLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en'),
      Locale('de'),
    ],
    onGenerateTitle: (context) => ChristmasCatsLocalizations.of(context).title,
    home: HomeScreen(),
  ));
}
