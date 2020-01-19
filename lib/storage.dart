import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storage = Storage();

class Storage {
  final coins = BehaviorSubject.seeded(0);

  SharedPreferences shPref;

  int get highScore1 {
    try {
      return shPref?.getInt('highScore1') ?? 0;
    } on TypeError {
      return 0;
    }
  }

  int get highScore2 {
    try {
      return shPref?.getInt('highScore2') ?? 0;
    } on TypeError {
      return 0;
    }
  }

  int get highScore3 {
    try {
      return shPref?.getInt('highScore3') ?? 0;
    } on TypeError {
      return 0;
    }
  }

  Future<void> init() async {
    if (shPref == null) {
      shPref = await SharedPreferences.getInstance();

      try {
        coins.add(shPref.getInt('coins') ?? 0);
      } on TypeError {
        // Nothing to do
      }
    }
  }

  Future<void> addCoins(int amount) async {
    final newCoins = coins.value + amount;
    coins.add(newCoins);
    await shPref.setInt('coins', newCoins);
  }

  Future<void> addScore(int score) async {
    if (score > highScore1) {
      await shPref.setInt('highScore3', highScore2);
      await shPref.setInt('highScore2', highScore1);
      await shPref.setInt('highScore1', score);
    } else if (score > highScore2) {
      await shPref.setInt('highScore3', highScore2);
      await shPref.setInt('highScore2', score);
    } else if (score > highScore3) {
      await shPref.setInt('highScore3', score);
    }
  }
}
