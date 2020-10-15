import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';
import 'package:boxgame/components/backyard.dart';
import 'package:boxgame/components/fly.dart';
import 'package:boxgame/components/house-fly.dart';
import 'package:boxgame/components/agile-fly.dart';
import 'package:boxgame/components/drooler-fly.dart';
import 'package:boxgame/components/hungry-fly.dart';
import 'package:boxgame/components/macho-fly.dart';
import 'package:boxgame/view.dart';
import 'package:boxgame/views/home-view.dart';
import 'package:boxgame/components/start-button.dart';

class LangawGame extends Game with TapDetector {
  Size screenSize;
  double tileSize;
  Backyard background;
  List<Fly> flies;
  Random rnd;
  View activeView = View.home;
  HomeView homeView;
  StartButton startButton;

  LangawGame() {
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    background = Backyard(this);
    homeView = HomeView(this);
    startButton = StartButton(this);
    spawnFly();
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize * 2.025);
    double y = rnd.nextDouble() * (screenSize.height - tileSize * 2.025);
    switch (rnd.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(AgileFly(this, x, y));
        break;
      case 3:
        flies.add(MachoFly(this, x, y));
        break;
      case 4:
        flies.add(HungryFly(this, x, y));
        break;
    }
    // flies.add(HouseFly(this, x, y));
    // flies.add(Fly(this, x, y));
    // flies.add(Fly(this, 50, 50));
  }

  void render(Canvas canvas) {
    // draw background
    // Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    // Paint bgPaint = Paint();
    // bgPaint.color = Color(0xff576574);
    // canvas.drawRect(bgRect, bgPaint);

    background.render(canvas);

    flies.forEach((Fly fly) => fly.render(canvas));

    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
    }
  }

  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    super.resize(size);
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled) {
      flies.forEach((Fly fly) {
        if (fly.flyRect.contains(d.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
        }
      });
    }
    // handle taps here
    // flies.forEach((Fly fly) {
    //   if (fly.flyRect.contains(d.globalPosition)) {
    //     fly.onTapDown();
    //   }
    // });
  }
}
