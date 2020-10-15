import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:boxgame/langaw-game.dart';

class Fly {
  final LangawGame game;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  Rect flyRect;
  // Paint flyPaint;
  bool isDead = false;
  bool isOffScreen = false;

  Fly(this.game, double x, double y) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    // flyPaint = Paint();
    // flyPaint.color = Color(0xff6ab04c);
  }

  // void render(Canvas c) {
  //   c.drawRect(flyRect, flyPaint);
  // }
  // void render(Canvas c) {}
  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, flyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, flyRect.inflate(2));
    }
  }

  void update(double t) {
    if (isDead) {
      print('Gia tri:');
      print(t);
      print(game.tileSize * 12 * t);
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);

      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      flyingSpriteIndex += 30 * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
    }
  }

  void onTapDown() {
    // flyPaint.color = Color(0xffff4757);
    isDead = true;

    game.spawnFly();
  }
}
