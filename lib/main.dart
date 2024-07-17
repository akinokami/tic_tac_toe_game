import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/splash_screen.dart';


void main() {
  runApp(const TicTacToeGame());
}

class TicTacToeGame extends StatelessWidget {
  const TicTacToeGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}







