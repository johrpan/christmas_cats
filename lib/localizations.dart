import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ChristmasCatsLocalizations {
  final Locale locale;

  final allStrings = {
    'en': {
      'title': 'Christmas Cats',
      'dedication': 'For Kira',
      'play': 'Play',
      'records': 'Records',
      'records1': '1. %i',
      'records2': '2. %i',
      'records3': '3. %i',
      'back': 'Back',
      'intro': 'Introduction',
      'ad': 'Support me',
      'noAds': 'No ads available',
      'poem': 'Cats are climbing Christmas trees,\n'
          'The trees are getting wiggly,\n'
          'You\'ll get a lot of trouble,\n'
          'If you don\'t tap them quickly.',
      'intro1': 'Cats are climbing Christmas trees,',
      'intro2': 'The trees are getting wiggly,',
      'intro3': 'You\'ll get a lot of trouble,',
      'intro4': 'If You don\'t tap them quickly.',
      'paused': 'Paused',
      'unpause': 'Continue',
      'exit': 'Exit',
      'gameOver': 'Game over!',
      'score': '%i Points',
      'tryAgain': 'Try again',
    },
    'de': {
      'title': 'Weihnachtskatzen',
      'dedication': 'Für Kira',
      'play': 'Spielen',
      'records': 'Rekorde',
      'records1': '1. %i',
      'records2': '2. %i',
      'records3': '3. %i',
      'back': 'Zurück',
      'intro': 'Einführung',
      'ad': 'Mich unterstützen',
      'noAds': 'Keine Werbung verfügbar',
      'poem': 'Katzen, die auf Tannen steigen,\n'
          'Welche sich gefährlich neigen,\n'
          'Du musst auf die Tannen tippen,\n'
          'Denn sonst werden diese kippen!',
      'intro1': 'Katzen, die auf Tannen steigen,',
      'intro2': 'Welche sich gefährlich neigen,',
      'intro3': 'Du musst auf die Tannen tippen,',
      'intro4': 'Denn sonst werden diese kippen!',
      'paused': 'Pausiert',
      'unpause': 'Weiter',
      'exit': 'Beenden',
      'gameOver': 'Spiel vorbei!',
      'score': '%i Punkte',
      'tryAgain': 'Nochmal',
    },
  };

  static const delegate = _ChristmasCatsLocalizationsDelegate();

  static ChristmasCatsLocalizations of(BuildContext context) =>
      Localizations.of(context, ChristmasCatsLocalizations);

  Map<String, String> get localizedStrings => allStrings[locale.languageCode];

  String get title => localizedStrings['title'];
  String get dedication => localizedStrings['dedication'];
  String get play => localizedStrings['play'];
  String get records => localizedStrings['records'];
  String get records1 => localizedStrings['records1'];
  String get records2 => localizedStrings['records2'];
  String get records3 => localizedStrings['records3'];
  String get back => localizedStrings['back'];
  String get intro => localizedStrings['intro'];
  String get ad => localizedStrings['ad'];
  String get noAds => localizedStrings['noAds'];
  String get poem => localizedStrings['poem'];
  String get intro1 => localizedStrings['intro1'];
  String get intro2 => localizedStrings['intro2'];
  String get intro3 => localizedStrings['intro3'];
  String get intro4 => localizedStrings['intro4'];
  String get paused => localizedStrings['paused'];
  String get unpause => localizedStrings['unpause'];
  String get exit => localizedStrings['exit'];
  String get gameOver => localizedStrings['gameOver'];
  String get score => localizedStrings['score'];
  String get tryAgain => localizedStrings['tryAgain'];

  ChristmasCatsLocalizations(this.locale);
}

class _ChristmasCatsLocalizationsDelegate
    extends LocalizationsDelegate<ChristmasCatsLocalizations> {
  const _ChristmasCatsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<ChristmasCatsLocalizations> load(Locale locale) =>
      SynchronousFuture(ChristmasCatsLocalizations(locale));

  @override
  bool shouldReload(LocalizationsDelegate<ChristmasCatsLocalizations> old) =>
      false;
}
