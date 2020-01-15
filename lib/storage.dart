import 'package:shared_preferences/shared_preferences.dart';

final storage = Storage();

class Storage {
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
    shPref = await SharedPreferences.getInstance();
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
