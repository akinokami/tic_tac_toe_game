import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/string_const.dart';
import '../screens/game_result_dialog.dart';

class TicTacToeProvider extends ChangeNotifier {
  List<String> board = List.filled(9, '');
  String currentPlayer = basketball;
  PlayerState? _playerState;
  int playerSingleScore = 0;
  int playerSingle1Score = 0;
  int player1Score = 0;
  int player2Score = 0;
  String winner = '';
  Random random = Random();
  bool isVisible = true; // Controls visibility of the text
  late Timer timer;
  final player = AudioPlayer();
  final player1 = AudioPlayer();
  bool isMuted = true;
  bool _isDisposed = false;
  void notifyListenersSafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  TicTacToeProvider() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      isVisible = !isVisible;
      notifyListenersSafely();
    });
    resetGame();
    init();
  }

  init() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    playerSingleScore = sh.getInt("playerSingleScore") ?? 0;
    playerSingle1Score = sh.getInt("playerSingle1Score") ?? 0;
    player1Score = sh.getInt("player1Score") ?? 0;
    player2Score = sh.getInt("player2Score") ?? 0;

    isMuted = sh.getBool("isMuted") ?? true;

    if (!isMuted) {
      playSound();
    } else {}
    notifyListenersSafely();
  }

  void playWinSound() async {
    player1.play(
      AssetSource('yay.mp3'),
    );
    player1.setVolume(1.0);
    Future.delayed(const Duration(seconds: 10)).then((value) => player1.stop());
  }

  void playSoundFail() async {
    player1.play(
      AssetSource('defeat.mp3'),
    );
    player1.setVolume(1.0);
    Future.delayed(const Duration(seconds: 10)).then((value) => player1.stop());
  }

  void playSound() async {
    if (_isDisposed) return;
    if (player.state == PlayerState.stopped) {

      await player.play(AssetSource('bgmusic.mp3'));
    }
    player.setVolume(1.0);
  }

  void muteUnMute() async {
    if (_isDisposed) return;
    SharedPreferences sh = await SharedPreferences.getInstance();
    isMuted = sh.getBool("isMuted") ?? true;
    print("From storage $isMuted");

    if (isMuted) {
      if (player.state == PlayerState.stopped) {

        await player.play(AssetSource('bgmusic.mp3'));
      }


      player.setVolume(1.0);
      isMuted = false;
    } else {
      player.stop();
      isMuted = true;
    }
    sh.setBool("isMuted", isMuted);
    print("Stored $isMuted");
    notifyListenersSafely();

    print(isMuted);
  }

  void resetGame() {
    board = List.filled(9, '');
    currentPlayer = basketball;
    winner = '';
    notifyListenersSafely();
  }

  ///Who win the game
  bool _checkWin() {
    const winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
      [0, 4, 8], [2, 4, 6], // diagonals
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] == currentPlayer &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[0]] == board[pattern[2]]) {
        return true;
      }
    }
    return false;
  }

  ///For single player mode (computer move)
  void _makeComputerMove(bool singlePlayer, BuildContext context) {
    List<int> availableMoves = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        availableMoves.add(i);
      }
    }
    if (availableMoves.isNotEmpty) {
      int move = availableMoves[random.nextInt(availableMoves.length)];
      handleTap(move, singlePlayer, context);
    }
  }

  void updateScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('playerSingleScore', playerSingleScore);
    prefs.setInt('playerSingle1Score', playerSingle1Score);
    prefs.setInt('player1Score', player1Score);
    prefs.setInt('player2Score', player2Score);
  }

  void showEndGameDialog(BuildContext context, String result,bool singlePlayer) {
    final ticTacToeProvider =
        Provider.of<TicTacToeProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GameResultDialog(
          isSinglePlayer: singlePlayer,
          result: result,
          ticTacToeProvider: ticTacToeProvider,
        );
      },
    );
  }

  void handleTap(int index, bool singlePlayer, BuildContext context) {
    {
      if (board[index] == '' && winner == '') {
        board[index] = currentPlayer;
        if (_checkWin()) {
          winner = currentPlayer;
          if(!singlePlayer){
            if (winner == basketball) {
              player1Score = player1Score + 10;

              updateScore();
              playWinSound();
            } else {
              if (!singlePlayer) player2Score = player2Score + 10;
              updateScore();
              playWinSound();
            }
          }else{

            if (winner == basketball) {
              playerSingleScore = playerSingleScore + 10;
              updateScore();
              playWinSound();
            } else {
              playerSingle1Score = playerSingle1Score + 10;
              updateScore();
              playWinSound();
            }
          }
          showEndGameDialog(context, winner,singlePlayer);
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> CelebrateScreen(winner: winner,)));
        } else if (!board.contains('')) {
          winner = draw;
          // player1Score = player1Score + 1;
          // if (!singlePlayer) player2Score = player2Score + 1;
          updateScore();
          playSoundFail();
          showEndGameDialog(context, winner,singlePlayer);
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> CelebrateScreen(winner: winner,)));
        } else {
          currentPlayer = currentPlayer == basketball ? soccer : basketball;
          if (singlePlayer && currentPlayer == soccer) {
            // _makeComputerMove();
            Future.delayed(const Duration(milliseconds: 200),
                () => _makeComputerMove(singlePlayer, context));
          }
        }
        notifyListenersSafely();
      }
    }
  }

  @override
  void dispose() {
    print('Disposing TicTacToeProvider');
    _isDisposed = true;
    timer.cancel();
    player.stop().then((_) => player.dispose());
    player1.stop().then((_) => player1.dispose());
    super.dispose();
  }
}
