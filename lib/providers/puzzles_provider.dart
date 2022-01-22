import 'package:chuzzlez/models/puzzles.dart';
import 'package:chuzzlez/services/fire_store_services.dart';
import 'package:flutter/cupertino.dart';

class PuzzlesProvider with ChangeNotifier {
  late int levelCount;
  bool read = false;
  late FireStoreServices instance = FireStoreServices();
  Puzzles puzzles = Puzzles();
  readMap() async {
    var puzzlesMaps = await instance.getLevels();
    puzzles.length = puzzlesMaps.length;
    for (var i = 0; i < puzzles.length; i++) {
      var puzzlesMap = puzzlesMaps[i];

      // if (_puzzlesList.length < length) {
      puzzles.puzzlesList.add(Puzzles(
          levelNumber: puzzlesMap['levelNumber'],
          pgn: puzzlesMap['pgn'],
          solution: puzzlesMap['solution']));
      // }
    }

    levelCount = puzzles.puzzlesList.length;
    read = true;

    // print(_puzzlesList);
    // print(length);
  }

  int get getCount {
    return levelCount;
  }

  Puzzles getPuzzle(int index) {
    return puzzles.puzzlesList[index];
  }

  List<Puzzles> get getPuzzles {
    return puzzles.puzzlesList;
  }
}
