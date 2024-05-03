import 'dart:developer' as dev;
import 'dart:math';

import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/core/models/question.dart';

class GameRepository {
  static const points = [
    [140, 80, 40, 20, 10, 5],
    [280, 160, 80, 40, 20, 10],
    [15, 30, 60, 120, 240, 420]
  ];

  late Player me;
  late Player enemy;
  late List<String> rightAnswers;
  late List<String> wrongAnswers;
  late String langCode;

  int round = 0;
  int roundScore = 0;
  int myScore = 0;
  int enemyScore = 0;
  String myAnswer = '';
  String enemyAnswer = '';
  int diceEnemy = 0;
  bool started = false;

  bool get isStarted => started;

  bool isFinalRound() {
    return round == points.length - 1;
  }

  bool isVVComplete() {
    var complete = myAnswer != '' && enemyAnswer != '';
    if (complete) dev.log('All answers have been received. AI: "$enemyAnswer". Player: "$myAnswer"');
    return complete;
  }

  bool nextRound() {
    if (round < points.length - 1) {
      round++;
      roundScore = 0;
      return true;
    }
    return false;
  }

  void setAnswer(String answer, bool isMe) {
    if (isMe) {
      myAnswer = answer;
    } else {
      enemyAnswer = answer;
    }
  }

  String getAnswer() {
    int random = Random().nextInt(100);
    String answer;

    if (isFinalRound()) {
      answer = (random > 60)
          ? wrongAnswers[Random().nextInt(wrongAnswers.length)]
          : rightAnswers[Random().nextInt(rightAnswers.length)].split(',')[0];
    } else {
      answer = (wrongAnswers.isEmpty ? true : random > 60)
          ? rightAnswers[Random().nextInt(rightAnswers.length)].split(',')[0]
          : wrongAnswers[Random().nextInt(wrongAnswers.length)];
    }

    dev.log('AI say: $answer (${random > 60 ? 'no cheat' : '60% cheat'})');
    return answer;
  }

  int getPoints(int placeIndex) {
    return points[round][placeIndex];
  }

  String getPlayerName(bool isMe) {
    return isMe ? me.nickname : enemy.nickname;
  }

  void makeAnswerUnavailable(String answer) {
    wrongAnswers.remove(answer.toLowerCase());
    rightAnswers.removeWhere((element) => element.split(',').contains(answer.toLowerCase()));
  }

  void addScore(int points) {
    roundScore += points;
  }

  int enemyDiceRoll() {
    diceEnemy = Random().nextInt(6);
    dev.log('AI got the number ${diceEnemy + 1}');
    return diceEnemy;
  }

  int myDiceRoll() {
    if (Random().nextInt(100) < 55) {
      var diceMe = diceEnemy + Random().nextInt(6 - diceEnemy);
      dev.log('Player got the number ${diceMe + 1} (55% cheat)');
      return diceMe;
    }

    var diceMe = Random().nextInt(6);
    while (diceMe == diceEnemy) {
      diceMe = Random().nextInt(6);
    }
    dev.log('Player got the number ${diceMe + 1} (no cheat)');
    return diceMe;
  }

  void payWin(bool winnerIsMe) {
    if (winnerIsMe) {
      myScore += roundScore;
      dev.log('${me.nickname} got a fund of round ($roundScore)');
    } else {
      enemyScore += roundScore;
      dev.log('${enemy.nickname} got a fund of round ($roundScore)');
    }
  }

  List<(Player, int, int)> getRoundResults(bool winnerIsMe) {
    return [
      (me, winnerIsMe ? roundScore : 0, myScore),
      (enemy, winnerIsMe ? 0 : roundScore, enemyScore),
    ];
  }

  void startGame(Player me, Player enemy, String langCode) {
    this.me = me;
    this.enemy = enemy;
    this.langCode = langCode;

    dev.log('Game started. ${this.me.nickname} vs ${this.enemy.nickname}');
    started = true;
  }

  void setQuestion(Question question) {
    rightAnswers = List.from(question.rightAnswers);
    wrongAnswers = List.from(question.wrongAnswers);
    dev.log('Round ${round + 1}. Question is: "${question.text} ..."');
  }
}
