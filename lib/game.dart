import 'dart:math';
import 'dart:ui';

import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

import 'components/cat.dart';
import 'components/tree.dart';
import 'localizations.dart';

final random = Random(DateTime.now().millisecondsSinceEpoch);

extension RandomPicker<T> on List<T> {
  T pick() {
    final index = random.nextInt(length);
    return this.removeAt(index);
  }
}

class Cell {
  final int x;
  final int y;

  // A number for doing random things in a deterministic way
  final r = random.nextDouble();

  Tree tree;
  Cat cat;

  Cell(this.x, this.y);
}

class ChristmasCats extends BaseGame with Tapable {
  static const marginTop = 64.0;
  static const marginLRB = 8.0;
  static const nColumns = 5;
  static const nRows = 6;
  static const nCells = nColumns * nRows;
  static const nTrees = nCells - 14;
  static const treeProbability = 0.6;
  static const minCatWait = 500;
  static const maxCatWait = 2000;

  final ChristmasCatsLocalizations localizations;
  final Size size;
  final bgSprite = Sprite('background.png');
  final void Function(int score) onScoreChanged;
  final void Function(int paws) onPawsChanged;
  final void Function() onGameOver;
  final List<Timer> timers = [];
  final List<Cat> cats = [];
  final List<Tree> trees = [];

  double get cellWidth => (size.width - 2 * marginLRB) / nColumns;
  double get cellHeight => (size.height - (marginTop + marginLRB)) / nRows;

  bool paused = true;
  int nCats = 0;
  int paws = 3;
  int score = 0;
  bool gameOver = false;

  Timer nextCatTimer;
  Timer scoreTimer;
  List<Cell> cells;
  List<int> treeCells;
  List<int> emptyCells;

  ChristmasCats({
    this.localizations,
    this.size,
    this.onScoreChanged,
    this.onPawsChanged,
    this.onGameOver,
  });

  Vector2 getTreePosition(Cell cell) {
    final x = marginLRB + (cell.x + 0.5) * cellWidth;
    final y = marginTop + (cell.y + 1) * cellHeight;
    final offsetX = cell.r * 20.0 - 10.0;
    final offsetY = cell.r * -20.0;
    return Vector2(x + offsetX, y + offsetY);
  }

  Vector2 getCatPosition(Cell cell) {
    if (cell.tree != null) {
      return getTreePosition(cell) + Vector2(0.0, -10.0);
    } else {
      final x =
          marginLRB + (cell.x + 0.2 + 0.6 * random.nextDouble()) * cellWidth;
      final y =
          marginTop + (cell.y + 0.2 + 0.6 * random.nextDouble()) * cellHeight;
      return Vector2(x, y);
    }
  }

  void updateCat(int oldCellIndex, Cat cat) {
    int newCellIndex;

    if (oldCellIndex != null) {
      if (treeCells.length > 0 && random.nextDouble() < treeProbability) {
        newCellIndex = treeCells.pick();
      } else {
        newCellIndex = emptyCells.pick();
      }

      final oldCell = cells[oldCellIndex];
      oldCell.cat = null;
      if (oldCell.tree != null) {
        treeCells.add(oldCellIndex);
      } else {
        emptyCells.add(oldCellIndex);
      }
    } else {
      newCellIndex = emptyCells.pick();
    }

    final newCell = cells[newCellIndex];
    newCell.cat = cat;
    cat.onBored = () {
      if (newCell.tree != null) {
        newCell.tree.shake();
      } else {
        final ms = random.nextInt(maxCatWait - minCatWait) + minCatWait;
        Timer timer;
        timer = Timer(ms / 1000, callback: () {
          updateCat(newCellIndex, cat);
        });
        timer.start();
        timers.add(timer);
      }
    };

    cat.runTo(getCatPosition(newCell));
  }

  void createCat() {
    final cat = Cat();
    add(cat);
    cats.add(cat);
    updateCat(null, cat);

    nextCatTimer = Timer(20.0 + nCats * 10.0, callback: createCat);
    nextCatTimer.start();

    nCats++;
  }

  void reset() {
    paused = true;
    nCats = 0;
    paws = 3;
    score = 0;
    gameOver = false;

    cells = [];
    treeCells = [];
    emptyCells = [];

    for (final timer in timers) {
      timer.stop();
    }

    timers.clear();

    for (final cat in cats) {
      cat.shouldDestroy = true;
    }

    cats.clear();

    for (final tree in trees) {
      tree.shouldDestroy = true;
    }

    trees.clear();

    for (var i = 0; i < nCells; i++) {
      cells.add(Cell((i / nRows).floor(), i % nRows));
      emptyCells.add(i);
    }

    for (var i = 0; i < nTrees; i++) {
      final cellIndex = emptyCells.pick();
      final cell = cells[cellIndex];
      final tree = Tree(getTreePosition(cell), () {
        cell.tree.kill();

        paws -= 1;
        onPawsChanged(paws);

        if (paws <= 0 && !gameOver) {
          scoreTimer.stop();
          gameOver = true;
          onGameOver();
        }

        cell.tree = null;
        updateCat(cellIndex, cell.cat);
      });
      cell.tree = tree;
      treeCells.add(cellIndex);
      trees.add(tree);
    }

    createCat();

    for (final tree in trees) {
      add(tree);
    }

    scoreTimer = Timer(0.5, repeat: true, callback: () {
      score++;
      onScoreChanged(score);
    });
    scoreTimer.start();
  }

  void play() {
    paused = false;
  }

  void pause() {
    paused = true;
  }

  @override
  void render(Canvas canvas) {
    bgSprite.render(canvas, width: size.width, height: size.height);
    super.render(canvas);
  }

  @override
  void update(double t) {
    if (!paused) {
      nextCatTimer?.update(t);
      scoreTimer?.update(t);

      final List<Timer> oldTimers = [];
      for (final timer in timers) {
        timer.update(t);
        if (timer.isFinished()) {
          oldTimers.add(timer);
        }
      }

      for (final timer in oldTimers) {
        timers.remove(timer);
      }

      super.update(t);
    }
  }

  @override
  Rect toRect() => Rect.fromLTWH(0.0, 0.0, size.width, size.height);

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);

    if (!paused) {
      final x = details.localPosition.dx;
      final y = details.localPosition.dy;

      final cellX = ((x - marginLRB) / cellWidth).floor();
      final cellY = ((y - marginTop) / cellHeight).floor();
      final cellIndex = cellX * nRows + cellY;

      if (cellIndex >= 0 && cellIndex < cells.length) {
        final cell = cells[cellIndex];

        if (cell?.tree != null) {
          cell.tree.stopShaking();

          if (cell.cat != null) {
            updateCat(cellIndex, cell.cat);
            score += 25;
          } else {
            score -= 25;
          }

          onScoreChanged(score);
        }
      }
    }
  }
}
