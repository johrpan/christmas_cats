import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../localizations.dart';
import '../storage.dart';

import 'menu_entry.dart';

class GetCoins extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = ChristmasCatsLocalizations.of(context);

    return MenuEntry(
      text: localizations.getCoins,
      onTap: () {
        final scaffold = Scaffold.of(context);
        scaffold.showSnackBar(SnackBar(
          content: Text(localizations.adLoading),
          // Show it until the ad is loaded
          duration: Duration(minutes: 1),
        ));

        final ad = RewardedVideoAd.instance;
        ad.listener = (event, {rewardAmount, rewardType}) {
          scaffold.removeCurrentSnackBar();
          if (event == RewardedVideoAdEvent.loaded) {
            ad.show();
          } else if (event == RewardedVideoAdEvent.failedToLoad) {
            scaffold.showSnackBar(SnackBar(
              content: Text(localizations.noAds),
              duration: const Duration(seconds: 2),
            ));
          } else if (event == RewardedVideoAdEvent.rewarded) {
            storage.addCoins(rewardAmount);
          }
        };

        ad.load(
          adUnitId: kReleaseMode
              ? 'ca-app-pub-4129701777413448/6712208196'
              : RewardedVideoAd.testAdUnitId,
          targetingInfo: MobileAdTargetingInfo(),
        );
      },
    );
  }
}
