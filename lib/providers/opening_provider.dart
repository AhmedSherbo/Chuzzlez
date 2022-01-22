import 'package:chuzzlez/models/openings.dart';
import 'package:flutter/cupertino.dart';
import 'package:chuzzlez/services/fire_store_services.dart';

class OpeningProvider with ChangeNotifier {
  final List<Openings> _openingsList = [];
  late FireStoreServices instance = FireStoreServices();
  late int levelCount;
  late int length;
  late String description;
  bool read = false;

  readMap() async {
    var openingsMaps = await instance.getOpenings();
    length = openingsMaps.length;
    for (var i = 0; i < length; i++) {
      var openingsMap = openingsMaps[i];
      if (_openingsList.length < length) {
        _openingsList.add(Openings(
          description: openingsMap['description'],
          openingName: openingsMap['openingName'],
          solution: openingsMap['solution'],
        ));
      }
    }
    levelCount = _openingsList.length;
    read = true;
  }

  OpeningProvider() {
    levelCount = _openingsList.length;
  }

  int get getCount {
    return levelCount;
  }

  String getOpening(String name) {
    for (int i = 0; i < _openingsList.length; i++) {
      if (_openingsList[i].openingName == name) {
        return _openingsList[i].solution;
      }
    }
    throw '';
  }

  List<Openings> get getOpenings {
    return _openingsList;
  }
}
