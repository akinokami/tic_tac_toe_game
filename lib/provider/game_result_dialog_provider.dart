import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class GameResultProvider extends ChangeNotifier{
  bool isVisible = true;
  late ConfettiController controllerTopCenter;
  late Timer timer;

  GameResultProvider(){
    timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      isVisible = !isVisible;
      notifyListeners();
    });
    controllerTopCenter = ConfettiController(duration: const Duration(seconds: 60));
    controllerTopCenter.play();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controllerTopCenter.dispose();
    timer.cancel();
    super.dispose();
  }
}