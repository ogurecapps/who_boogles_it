import 'dart:math';

import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/core/models/question.dart';
import 'package:who_boogles_it/core/util/logger.dart';

class GameRepository {
  static const points = [
    [140, 80, 40, 20, 10, 5],
    [280, 160, 80, 40, 20, 10],
    [15, 30, 60, 120, 240, 420]
  ];

  late String langCode;
  late Player me;
  late Player enemy;
  // dynamic
  late List<String> rightAnswers;
  late List<String> wrongAnswers;
  // fixed
  late List<String> allAnswers;

  int round = 0;
  int roundScore = 0;
  int myScore = 0;
  int enemyScore = 0;
  String myAnswer = '';
  String enemyAnswer = '';
  int diceEnemy = 0;
  int questionId = 0;
  bool started = false;

  bool get isStarted => started;

  void resetGame() {
    round = 0;
    roundScore = 0;
    myScore = 0;
    enemyScore = 0;
    myAnswer = '';
    enemyAnswer = '';

    Logger.print('Game has been reset');
  }

  bool isKnownAnswer(String answer) {
    return allAnswers.indexWhere((element) => element.split(',').contains(answer.toLowerCase())) >= 0;
  }

  bool isFinalRound() {
    return round == points.length - 1;
  }

  bool isAnswersReceived() {
    var complete = myAnswer != '' && enemyAnswer != '';
    if (complete) Logger.print('All answers have been received. AI: "$enemyAnswer". Player: "$myAnswer"');
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
      myAnswer = answer.toLowerCase();
    } else {
      enemyAnswer = answer.toLowerCase();
    }
  }

  String getAnswer() {
    int random = Random().nextInt(100);
    String answer;
    var percent = 60; // Default

    if (isFinalRound()) {
      bool right;

      if (random > percent) {
        answer = wrongAnswers[Random().nextInt(wrongAnswers.length)];
        right = false;
      } else {
        answer = rightAnswers[Random().nextInt(rightAnswers.length)];
        right = true;
      }

      if (right) {
        while (answer.split(',').contains(myAnswer)) {
          answer = rightAnswers[Random().nextInt(rightAnswers.length)];
        }
        answer = answer.split(',')[0];
      }
    } else {
      var level = (enemy.winCounter / 3).floor() + 1;

      if (level > 70) {
        percent = 42; // Elite
      } else if (level > 40) {
        percent = 46; // Expert
      } else if (level > 20) {
        percent = 56; // Professional
      } else if (level > 4) {
        percent = 58; // User
      }

      answer = (wrongAnswers.isEmpty ? true : random > percent)
          ? rightAnswers[Random().nextInt(rightAnswers.length)].split(',')[0]
          : wrongAnswers[Random().nextInt(wrongAnswers.length)];
    }

    Logger.print('AI say: $answer (${random > percent ? 'no cheat' : '$percent% cheat'})');
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
    if (!isFinalRound()) {
      rightAnswers.removeWhere((element) => element.split(',').contains(answer.toLowerCase()));
    }
  }

  void addScore(int points) {
    roundScore += points;
  }

  void addPlayerScore(int points, bool winnerIsMe) {
    if (winnerIsMe) {
      myScore += points;
    } else {
      enemyScore += points;
    }
  }

  int enemyDiceRoll() {
    diceEnemy = Random().nextInt(6);
    Logger.print('AI got the number ${diceEnemy + 1}');
    return diceEnemy;
  }

  int myDiceRoll() {
    if (Random().nextInt(100) < 53) {
      var diceMe = diceEnemy + Random().nextInt(6 - diceEnemy);
      Logger.print('Player got the number ${diceMe + 1} (53% cheat)');
      return diceMe;
    }

    var diceMe = Random().nextInt(6);
    while (diceMe == diceEnemy) {
      diceMe = Random().nextInt(6);
    }
    Logger.print('Player got the number ${diceMe + 1} (no cheat)');
    return diceMe;
  }

  void payWin(bool winnerIsMe) {
    if (winnerIsMe) {
      myScore += roundScore;
      Logger.print('${me.nickname} got a fund of round ($roundScore)');
    } else {
      enemyScore += roundScore;
      Logger.print('${enemy.nickname} got a fund of round ($roundScore)');
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

    Logger.print('Game started. ${this.me.nickname} vs ${this.enemy.nickname}');
    started = true;
  }

  void setQuestion(Question question) {
    rightAnswers = List.from(question.rightAnswers);
    wrongAnswers = List.from(question.wrongAnswers);
    allAnswers = List.from(rightAnswers)..addAll(wrongAnswers);
    questionId = question.questionId;

    Logger.print('Round ${round + 1}. Question is: "${question.text} ..."');
  }
}
