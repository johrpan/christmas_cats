import 'dart:ui';
import 'dart:math';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';
import 'package:vector_math/vector_math_64.dart';

final random = Random(DateTime.now().millisecondsSinceEpoch);

class Tree extends PositionComponent {
  final anchor = Anchor.bottomCenter;
  final void Function() onDestroy;
  final treeNumber = random.nextInt(4) + 1;

  bool shouldDestroy = false;
  Timer nextLevelTimer;
  Timer killTimer;
  int shakeLevel = 0;
  bool shakingLeft = true;
  double get shakeAngle => shakeLevel * shakeLevel * pi / 1000;

  double get width => treeNumber <= 2 ? 80.0 : 70.0;
  double get height => treeNumber <= 2 ? 100.0 : 80.0;

  Sprite sprite;

  Tree(Vector2 position, this.onDestroy) {
    x = position.x;
    y = position.y;

    sprite = Sprite('tree$treeNumber.png');

    nextLevelTimer = Timer(
      0.1,
      repeat: true,
      callback: () {
        shakeLevel++;
        if (shakeLevel > 16 && onDestroy != null) {
          onDestroy();
        }
      },
    );

    killTimer = Timer(1, callback: () {
      shouldDestroy = true;
    });
  }

  void shake() {
    if (shakeLevel == 0) {
      shakeLevel = 1;
      nextLevelTimer.start();
    }
  }

  void stopShaking() {
    shakeLevel = 0;
    nextLevelTimer.stop();
  }

  void kill() {
    shakeLevel = -1;
    nextLevelTimer.stop();
    killTimer.start();
  }

  @override
  void render(Canvas c) {
    prepareCanvas(c);
    sprite.render(c, width: width, height: height);
  }

  @override
  void update(double t) {
    nextLevelTimer.update(t);
    killTimer.update(t);

    if (shakeLevel >= 0) {
      if ((angle - shakeAngle).abs() > 0.01) {
        if (shakingLeft) {
          angle -= t * (shakeLevel + 1) / 3;
          if (angle < -shakeAngle) {
            shakingLeft = false;
          }
        } else {
          angle += t * (shakeLevel + 1) / 3;
          if (angle > shakeAngle) {
            shakingLeft = true;
          }
        }
      }
    } else {
      if (shakingLeft) {
        if (angle > -0.5 * pi) {
          angle -= t * 10;
        }
      } else {
        if (angle < 0.5 * pi) {
          angle += t * 10;
        }
      }
    }
  }

  @override
  bool destroy() => shouldDestroy;

  @override
  int priority() => 20000 + y.floor();
}
