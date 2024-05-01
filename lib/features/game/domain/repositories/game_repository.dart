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
  int diceEnemy = 0;
  bool started = false;

  bool get isStarted => started;

  void nextRound() {
    round++;
    roundScore = 0;
  }

  String getAnswer() {
    final String answer = (wrongAnswers.isEmpty ? true : Random().nextInt(100) > 60)
        ? rightAnswers[Random().nextInt(rightAnswers.length)].split(',')[0]
        : wrongAnswers[Random().nextInt(wrongAnswers.length)];
    dev.log('AI say: $answer');
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
    return diceEnemy;
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

  void startGame(Player me, Player enemy, Question question, String langCode) {
    this.me = me;
    this.enemy = enemy;
    this.langCode = langCode;

    dev.log('Game started. ${this.me.nickname} vs ${this.enemy.nickname}');
    started = true;

    nextQuestion(question);
  }

  void nextQuestion(Question question) {
    rightAnswers = List.from(question.rightAnswers);
    wrongAnswers = List.from(question.wrongAnswers);
    dev.log('Round ${round + 1}. Question is: "${question.text} ..."');
  }
}
