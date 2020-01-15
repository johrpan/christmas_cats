import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:sprintf/sprintf.dart';

import '../localizations.dart';

class Progress extends Component with Resizable {
  static const height = 2.0;
  static const color = Color(0xff000000);

  static const subtileTextConfig = TextConfig(
    fontSize: 28.0,
    fontFamily: 'Tangerine',
    textAlign: TextAlign.center,
  );

  final ChristmasCatsLocalizations localizations;
  final void Function() onComplete;

  int rounds = 0;
  double progress = 0.0;
  double seconds = 0.0;
  bool playing = false;
  bool completed = false;

  double get endSeconds => 20.0 + rounds * 10.0;
  int get score => (2 * (rounds * endSeconds + seconds)).floor();

  Progress(this.localizations, this.onComplete);

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = color;
    final width = (seconds / endSeconds) * size.width;
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);
    subtileTextConfig.render(
      canvas,
      sprintf(localizations.score, [score]),
      Position(size.width / 2, 4),
      anchor: Anchor.topCenter,
    );
  }

  @override
  void update(double dt) {
    if (playing && !completed) {
      seconds += dt;
      if (seconds > endSeconds) {
        completed = true;
        if (onComplete != null) {
          rounds++;
          seconds = 0;
          onComplete();
        }
      }
    } else if (seconds < endSeconds) {
      completed = false;
    }
  }
}
