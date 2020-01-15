import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../localizations.dart';
import '../widgets/menu.dart';
import '../widgets/menu_entry.dart';

import 'game.dart';
import 'intro.dart';
import 'records.dart';

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
                )),
          ),
          MenuEntry(
            text: localizations.records,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordsScreen(),
                )),
          ),
          MenuEntry(
            text: localizations.intro,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IntroScreen(),
                )),
          ),
          Builder(
            builder: (context) => MenuEntry(
              text: localizations.ad,
              onTap: () {
                final ad = RewardedVideoAd.instance;

                ad.listener = (event, {rewardAmount, rewardType}) {
                  if (event == RewardedVideoAdEvent.loaded) {
                    ad.show();
                  } else if (event == RewardedVideoAdEvent.failedToLoad) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(localizations.noAds),
                      duration: const Duration(seconds: 2),
                    ));
                  } else if (event == RewardedVideoAdEvent.rewarded) {
                    // TODO: Reward user
                  }
                };

                ad.load(
                  adUnitId: 'ca-app-pub-4129701777413448/6712208196',
                  targetingInfo: MobileAdTargetingInfo(),
                );
              },
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
