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
      'shop': 'Shop',
      'coins': '%i Coins',
      'getCoins': 'Get coins',
      'adLoading': 'Ad loading',
      'noAds': 'No ads available',
      'poem': 'Cats are climbing Christmas trees,\n'
          'The trees are getting wiggly,\n'
          'You\'ll get a lot of trouble,\n'
          'If you don\'t tap them quickly.',
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
      'shop': 'Laden',
      'coins': '%i Münzen',
      'adLoading': 'Werbung wird geladen',
      'noAds': 'Keine Werbung verfügbar',
      'getCoins': 'Münzen bekommen',
      'poem': 'Katzen, die auf Tannen steigen,\n'
          'Welche sich gefährlich neigen,\n'
          'Du musst auf die Tannen tippen,\n'
          'Denn sonst werden diese kippen!',
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
  String get shop => localizedStrings['shop'];
  String get coins => localizedStrings['coins'];
  String get adLoading => localizedStrings['adLoading'];
  String get noAds => localizedStrings['noAds'];
  String get getCoins => localizedStrings['getCoins'];
  String get poem => localizedStrings['poem'];
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
