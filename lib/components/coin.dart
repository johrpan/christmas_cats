import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

import '../storage.dart';

class Coin extends PositionComponent {
  static const flightTime = 0.8;

  final sprite = Sprite('coin.png');
  final Vector2 position;
  final Vector2 target;

  Timer killTimer;
  bool shouldDestroy = false;

  bool flying = false;
  double flight = 0.0;
  
  Coin(this.position, this.target, void Function() onDestroy) {
    x = position.x;
    y = position.y;
    width = 24.0;
    height = 24.0;
    anchor = Anchor.center;

    killTimer = Timer(2.5, callback: () {
      onDestroy();
      shouldDestroy = true;
    });

    killTimer.start();
  }

  void tap() {
    killTimer.stop();
    flying = true;
    storage.addCoins(1);
  }

  @override
  void render(Canvas c) {
    prepareCanvas(c);
    sprite.render(c, width: width, height: height);
  }

  @override
  void update(double t) {
    killTimer.update(t);

    if (flying) {
      flight += t / flightTime;

      if (flight > 1.0) {
        flight = 1.0;
        flying = false;
        shouldDestroy = true;
      }

      x = lerpDouble(position.x, target.x, Curves.easeIn.transform(flight));
      y = lerpDouble(position.y, target.y, Curves.easeInBack.transform(flight));
    }
  }

  @override
  bool destroy() => shouldDestroy;

  @override
  int priority() => 25000;
}
