import 'dart:io';
import 'dart:math';

import 'constants.dart';

void main(List<String> args) {
  Game game = Game();
  game.startGame();
}

class Game {
  wait([int value = 300]) => Future.delayed(Duration(milliseconds: value));

  startGame() async {
    print(Constants.titleText);
    print(Constants.startsLine);
    await wait(700);
    int secretPos = randomInt(3) + 1;
    print(Constants.secretPoint(secretPos));
    print(Constants.mixinStart);
    await wait(1500);
    clear();
    var finalPos = await logic(secretPos);
    clear();
    print(Constants.startsLine);
    print(Constants.enterAnswer);
    int chosenPos = int.parse(stdin.readLineSync()!);
    await wait(700);
    print(chosenPos == finalPos
        ? Constants.winText
        : Constants.gameOwerText(finalPos));
  }

  Future<int> logic(int secretPos) async {
    final int mixinCount = randomInt(10) + 10;
    int x = secretPos;
    int y = randomInt(3) + 1;
    for (int i = 0; i < mixinCount; i++) {
      bool k = true;
      while (k == true) {
        if (y != x) {
          k = false;
        } else {
          y = randomInt(3) + 1;
        }
      }
      await showPostiton('x');
      await showPostiton('l$x$y');
      if ((x + y) == 4) {
        await showPostiton('y');
      }
      await showPostiton('r$x$y');
      await showPostiton('x');
      await wait();
      x = y;
    }
    return x;
  }

  int randomInt(int value) => Random.secure().nextInt(value);

  Future showPostiton(String rotate, {int time = 300}) async {
    String position = '';
    switch (rotate) {
      case 'x':
        position = Constants.lineX;
        break;
      case 'y':
        position = Constants.lineY;
        break;
      case 'l12':
      case 'l21':
        position = Constants.lineL12;
        break;
      case 'r12':
      case 'r21':
        position = Constants.lineR12;
        break;
      case 'l13':
      case 'l31':
        position = Constants.lineL13;
        break;
      case 'r13':
      case 'r31':
        position = Constants.lineR13;
        break;
      case 'l23':
      case 'l32':
        position = Constants.lineL23;
        break;
      case 'r23':
      case 'r32':
        position = Constants.lineR23;
        break;
    }
    clear(position);
    await wait();
  }

  clear([String value = '']) => print("\x1B[2J\x1B[0;0H$value");
}
