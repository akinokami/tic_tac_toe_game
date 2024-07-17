
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class Confetti extends StatelessWidget {
  const Confetti({
    super.key,
    required ConfettiController controllerTopCenter,
    required this.alignment,
  }) : _controllerTopCenter = controllerTopCenter;

  final ConfettiController _controllerTopCenter;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConfettiWidget(
        confettiController: _controllerTopCenter,
        blastDirection: -pi / 2,
        maxBlastForce: 20, // set a lower max blast force
        minBlastForce: 2, // set a lower min blast force
        emissionFrequency: 0.01,
        numberOfParticles: 20, // a lot of particles at once
        gravity: 0.8,
        // createParticlePath: drawStar,
      ),
    );
  }
}