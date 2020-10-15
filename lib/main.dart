import 'package:boxgame/box-game.dart';
import 'package:boxgame/langaw-game.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  LangawGame game = LangawGame();
  runApp(game.widget);
  // BoxGame game = BoxGame();
  // runApp(game.widget);
  // BoxGame game = BoxGame();
  // TapGestureRecognizer tapper = TapGestureRecognizer();
  // tapper.onTapDown = game.onTapDown;
  // runApp(game.widget);
  // flameUtil.addGestureRecognizer(tapper);
}