import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/tic_tac_toe_provider.dart';

import '../constants/img_const.dart';
import '../widgets/cus_outline_gradient_circle_button.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TicTacToeProvider>(
      create: (context) => TicTacToeProvider(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Score History",
            style: GoogleFonts.gamjaFlower(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomOutlineGradientCircleButton(
              iconData: Icons.arrow_back,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Consumer<TicTacToeProvider>(
          builder: (context, provider, _) => Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(modeImgPath),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                children: [

                  const SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: ListTile(
                          leading: Image.asset("assets/single.webp"),
                          title: Text(
                            "Your current score",
                            style: GoogleFonts.gamjaFlower(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),
                          subtitle: Text(
                            " Single player mode",
                            style: GoogleFonts.gamjaFlower(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.purple),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedNumberText(
                                provider.playerSingleScore, // int or double
                                curve: Curves.easeIn,
                                duration: const Duration(seconds: 1),
                                style:  GoogleFonts.gamjaFlower(fontSize: 30,color: Colors.purple),
                                // formatter: (value) {
                                //
                                //   return formatted;
                                // },
                              ),

                              Text(
                                " points",
                                style: GoogleFonts.gamjaFlower(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Image.asset("assets/multi.webp"),
                          title: Text(
                            "Your current score",
                            style: GoogleFonts.gamjaFlower(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),
                          subtitle: Text(
                            " Multi player mode",
                            style: GoogleFonts.gamjaFlower(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.purple),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedNumberText(
                                provider.player1Score, // int or double
                                curve: Curves.easeIn,
                                duration: const Duration(seconds: 1),
                                style:  GoogleFonts.gamjaFlower(fontSize: 30,color: Colors.purple),
                                // formatter: (value) {
                                //
                                //   return formatted;
                                // },
                              ),

                              Text(
                                " points",
                                style: GoogleFonts.gamjaFlower(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text("Your current score : ",style: GoogleFonts.gamjaFlower(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                      // Text(" ${provider.playerSingle1Score}",style: GoogleFonts.gamjaFlower(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.yellow),),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
