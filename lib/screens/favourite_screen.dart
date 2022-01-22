// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chuzzlez/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:chuzzlez/providers/puzzles_provider.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class FavouritePuzzleScreen extends StatefulWidget {
  FavouritePuzzleScreen({Key? key}) : super(key: key);

  @override
  _FavouritePuzzleState createState() => _FavouritePuzzleState();
}

class _FavouritePuzzleState extends State<FavouritePuzzleScreen> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).getUser;
    var levels = user.fav_puzzles;
    // List<dynamic> completedLevels2 = user.completedLevels;
    // List<int> completedLevels = completedLevels2.cast<int>();
    // print(completedLevels);
    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 15,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Puzzles List',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 100),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: Colors.black),
                ),
              )),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 100),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/puzzlecreator');
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(color: Colors.black),
                  ),
                )))
      ]),
      Flexible(
          child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: MediaQuery.of(context).size.height / 80,
        mainAxisSpacing: MediaQuery.of(context).size.width / 80,
        children: [
          for (int i = 0; i < levels.length; i++)
            Card(
                clipBehavior: Clip.hardEdge,
                color: Colors.cyanAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),
                child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      Navigator.pushNamed(context, '/puzzle').then((value) {
                        setState(() {});
                      });
                      Provider.of<UserProvider>(context, listen: false)
                          .loadPuzzle(levels[i] - 1);
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              child: FractionallySizedBox(
                            heightFactor: 0.5,
                          )),
                          Text("Level " + levels[i].toString()),
                          Flexible(
                              child: FractionallySizedBox(
                                  widthFactor: 1,
                                  heightFactor: 1,
                                  child: Opacity(
                                      opacity: 0.9,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent),
                                      ))))
                        ]))),
        ],
      ))

      // ignore: deprecated_member_use
    ]));
  }
}
