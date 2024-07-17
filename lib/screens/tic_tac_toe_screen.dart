import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/constants/font_style_const.dart';
import 'package:tic_tac_toe/constants/img_const.dart';
import 'package:tic_tac_toe/constants/string_const.dart';
import 'package:tic_tac_toe/provider/tic_tac_toe_provider.dart';
import 'package:tic_tac_toe/widgets/cus_outline_gradient_rect_button.dart';
import 'package:tic_tac_toe/widgets/cus_outline_gradient_circle_button.dart';

class TicTacToeHomePage extends StatelessWidget {
  final bool singlePlayer;

  const TicTacToeHomePage({super.key, required this.singlePlayer});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TicTacToeProvider>(
      create: (context) => TicTacToeProvider(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(gameBgImgPath), fit: BoxFit.cover),
          ),
          child: Consumer<TicTacToeProvider>(
            builder: (context, provider, _) => ListView(
              padding: EdgeInsets.all(10),
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                       EdgeInsets.only(top:MediaQuery.of(context).size.height*.04 , left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomOutlineGradientCircleButton(
                          iconData: Icons.arrow_back,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Text("Score", style: GoogleFonts.gamjaFlower(fontSize: 24,color: Colors.white),),
                      CustomOutlineGradientCircleButton(
                          iconData: provider.isMuted
                              ? Icons.volume_off
                              : Icons.volume_up_rounded,
                          onPressed: provider.muteUnMute),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ScoreWidget(
                        padding: 20,
                        title: player1Text,
                        playerScore: singlePlayer
                            ? provider.playerSingleScore:provider.player1Score,
                        topLeftRadius: Radius.elliptical(16, 14),
                        bottomRightRadius: Radius.circular(6)),
                    ScoreWidget(
                        padding: 20,
                        title: singlePlayer
                            ?"Computer": player2,
                        playerScore: singlePlayer
                            ? provider.playerSingle1Score:provider.player2Score,
                        topLeftRadius: Radius.circular(6),
                        bottomRightRadius: Radius.elliptical(16, 14))
                  ],
                ),

                const SizedBox(height: 30),
                AnimatedOpacity(
                  opacity: provider.isVisible ? 1.0 : 0.0, // Toggle opacity
                  duration: const Duration(
                      milliseconds: 500), // Duration for opacity change
                  child: Center(
                    child: Text(
                      provider.winner == ''
                          ? '$playerText ${provider.currentPlayer}\'s turn'
                          : "",
                      style: GoogleFonts.gamjaFlower(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () =>
                            provider.handleTap(index, singlePlayer, context),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(gridChildImgPath),
                                  fit: BoxFit.cover)),
                          child: Center(
                            child: provider.board[index] != ''
                                ? Image.asset(
                                    'assets/${provider.board[index]}.webp',
                                    width: 50,
                                    height: 50,
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                CustomOutlineGradientButton(
                  padding: 80,
                    horizon: 24,
                    vertical: 12,
                    data: Text(resetGame, style: homeButtonStyle),
                    onPressed: provider.resetGame,
                    buttonStyle: homeButtonStyle)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    super.key,
    required this.playerScore,
    required this.topLeftRadius,
    required this.bottomRightRadius, required this.title, required this.padding,
  });
  final String title;
  final int playerScore;
  final Radius topLeftRadius;
  final Radius bottomRightRadius;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: padding),
      child: OutlineGradientButton(
        child: Center(
          child: Row(
            children: [
              Text('$title : ',
                  style: GoogleFonts.gamjaFlower(fontSize: 16, color: Colors.white)),
              AnimatedNumberText(
                playerScore, // int or double
                curve: Curves.easeIn,
                duration: const Duration(seconds: 1),
                style:  GoogleFonts.gamjaFlower(fontSize: 30,color: Colors.yellow),
                // formatter: (value) {
                //
                //   return formatted;
                // },
              ),
              Text(' pts',
                  style: GoogleFonts.gamjaFlower(fontSize: 16, color: Colors.white)),

            ],
          ),
        ),
        gradient: const LinearGradient(
          stops: [0, 0.5, 0.5, 1],
          colors: [Colors.green, Colors.green, Colors.red, Colors.red],
        ),
        strokeWidth: 4,
        corners: Corners(topLeft: topLeftRadius, bottomRight: bottomRightRadius),
      ),
    );
  }
}
