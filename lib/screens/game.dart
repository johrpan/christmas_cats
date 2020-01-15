import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../game.dart';
import '../localizations.dart';
import '../storage.dart';
import '../widgets/transparent_route.dart';

import 'game_over.dart';
import 'pause.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int paws = 3;
  int score = 0;
  bool paused = false;
  ChristmasCats game;

  @override
  Widget build(BuildContext context) {
    final localizations = ChristmasCatsLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraints) {
              if (game == null) {
                game = ChristmasCats(
                  localizations: localizations,
                  size: constraints.biggest,
                  onPawsChanged: (paws) {
                    setState(() {
                      this.paws = paws;
                    });
                  },
                  onScoreChanged: (score) {
                    setState(() {
                      this.score = score;
                    });
                  },
                  onGameOver: () async {
                    storage.addScore(score);

                    final tryAgain = await Navigator.push(
                        context,
                        TransparentRoute(
                          builder: (context) => GameOverScreen(
                            score: score,
                          ),
                        ));

                    if (tryAgain != null && tryAgain) {
                      game.reset();
                      game.play();

                      setState(() {
                        paws = 3;
                        score = 0;
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                );

                game.reset();
                game.play();
              }

              return game.widget;
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  for (var i = 0; i < paws; i++) Icon(Icons.favorite),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                sprintf(localizations.score, [score]),
                style: TextStyle(
                  fontSize: 32.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.pause),
              onPressed: () async {
                game.pause();

                final unpause = await Navigator.push(
                    context,
                    TransparentRoute(
                      builder: (context) => PauseScreen(
                        score: score,
                      ),
                    ));

                if (unpause == null || unpause) {
                  game.play();
                } else {
                  storage.addScore(score);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
