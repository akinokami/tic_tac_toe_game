import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/constants/string_const.dart';
import 'package:tic_tac_toe/provider/game_result_dialog_provider.dart';
import 'package:tic_tac_toe/widgets/cus_outline_gradient_rect_button.dart';
import 'package:provider/provider.dart';
import '../provider/tic_tac_toe_provider.dart';
import '../widgets/confetti.dart';
import 'home_screen.dart';

class GameResultDialog extends StatelessWidget {
  final String result;
  final TicTacToeProvider ticTacToeProvider;
  final bool isSinglePlayer;
  const GameResultDialog(
      {super.key, required this.result, required this.ticTacToeProvider, required this.isSinglePlayer});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameResultProvider>(
      create: (context) => GameResultProvider(),
      child: Consumer<GameResultProvider>(
        builder: (context, provider, child) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 4),
                  image: const DecorationImage(
                      image: AssetImage('assets/dialog_bg.webp'),
                      fit: BoxFit.fill),
                ),
                height: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != 'Draw')
                      Confetti(
                        controllerTopCenter: provider.controllerTopCenter,
                        alignment: Alignment.topLeft,
                      ),
                    if (result != 'Draw')
                      Confetti(
                        controllerTopCenter: provider.controllerTopCenter,
                        alignment: Alignment.topCenter,
                      ),
                    if (result != 'Draw')
                      Confetti(
                        controllerTopCenter: provider.controllerTopCenter,
                        alignment: Alignment.topRight,
                      ),
                    result == 'Draw'
                        ? SizedBox(
                            height: 160,
                            child: Lottie.asset('assets/loser.json'))
                        : SizedBox(
                            height: 160,
                            child: Lottie.asset('assets/winner.json')),

                    AnimatedOpacity(
                      opacity: provider.isVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        result == 'Draw'
                            ? 'It\'s a Draw!'
                            :  (result == 'basketball'
                                ? 'Player 1 Wins !!'
                                : (isSinglePlayer?"Computer Wins":'Player 2 Wins !!')),
                        style: GoogleFonts.gamjaFlower(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    if (result != 'Draw') Center(
                      child: Text("10 points added to winner's score",
                          style: GoogleFonts.gamjaFlower(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomOutlineGradientButton(
                            padding: 20,
                            data: Icon(
                              Icons.home_filled,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              Future.delayed(const Duration(milliseconds: 800),
                                  () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              });
                            },
                            horizon: 8,
                            vertical: 8),
                        CustomOutlineGradientButton(
                            padding: 20,
                            data: Icon(
                              Icons.replay,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              ticTacToeProvider.resetGame();
                              Navigator.of(context).pop();
                            },
                            horizon: 8,
                            vertical: 8)
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
