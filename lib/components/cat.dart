import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:vector_math/vector_math_64.dart';

final random = Random(DateTime.now().millisecondsSinceEpoch);

class Cat extends PositionComponent {
  static const vmin = 0.1;
  static const vmax = 150.0;
  static const accLength = 20.0;
  static const minDistance = 4.0;

  final anchor = Anchor.bottomCenter;
  final renderFlipX = true;
  final axis = Vector2(-1.0, 0.0);

  final catNumber = random.nextInt(7) + 1;

  void Function() onBored;

  bool shouldDestroy = false;

  Vector2 target;
  Vector2 position;
  Vector2 velocity = Vector2.zero();
  bool bored = false;

  bool get isSitting => velocity.length < vmin;
  double get width => isSitting ? 25.0 : 40.0;
  double get height => isSitting ? 18.0 : 18.0;
  double get x => position.x;
  double get y => position.y;
  double get angle => -velocity.angleToSigned(axis);
  bool get renderFlipY => angle.abs() > 0.5 * pi;

  Sprite sitting;
  Sprite running;

  Cat() {
    sitting = Sprite('cat${catNumber}s.png');
    running = Sprite('cat${catNumber}r.png');
  }

  void runTo(Vector2 target) {
    bored = false;
    this.target = target;

    if (position == null) {
      position = target;
    }

    velocity = (target - position).normalized() * vmax;
  }

  @override
  void render(Canvas canvas) {
    prepareCanvas(canvas);

    if (isSitting) {
      sitting.render(canvas, width: width, height: height);
    } else {
      running.render(canvas, width: width, height: height);
    }
  }

  @override
  void update(double t) {
    if ((position - target).length < minDistance) {
      position = target;
      velocity.setZero();
      if (!bored) {
        bored = true;
        if (onBored != null) {
          onBored();
        }
      }
    } else {
      position += velocity * t;
    }
  }

  @override
  bool destroy() => shouldDestroy;

  @override
  int priority() => 10000;
}
