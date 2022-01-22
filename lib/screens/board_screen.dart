import 'package:chuzzlez/providers/opening_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class BoardScreen extends StatefulWidget {
  BoardScreen({Key? key}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<BoardScreen> {
  ChessBoardController controller = ChessBoardController();
  late Map query =
      ModalRoute.of(context)?.settings.arguments as Map<String, String>;
  late String solution;
  bool won = false;
  int moveCount = 0;
  bool isSwitched = false;
  bool undoneMove = false;
  late String sol;
  bool chosenColor = false;
  late PlayerColor color = PlayerColor.white;
  bool next = false;
  FlutterTts flutterTts = FlutterTts();
  void undoMove() {
    if (!controller.getSan().isEmpty) {
      controller.game.undo_move();
      controller.notifyListeners();
      moveCount -= 2;
    }
  }

  void getOpening(String name) {
    solution =
        Provider.of<OpeningProvider>(context, listen: false).getOpening(name);
    print(solution);
  }

  void openingMove() {
    List<String> solSplit = solution.split(',');
    if (moveCount < solSplit.length) {
      controller.makeMove(
          from: solSplit[moveCount], to: solSplit[moveCount + 1]);
      moveCount += 2;
    } else {
      print("Done");
    }
  }

  Widget overTheboard() {
    return Scaffold(
      body: ListView(children: [
        SizedBox(height: MediaQuery.of(context).size.height / 22),
        Center(
            child: Text('Chuzzlez',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))),
        ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
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
            ),
            Row(
              children: [
                Text(
                  'Toggle AI',
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = !isSwitched;
                    });
                  },
                )
              ],
            ),
          ],
        ),
        ChessBoard(
          controller: controller,
          boardColor: BoardColor.green,
          boardOrientation: color,
          enableUserMoves: !won,
        ),
        OutlinedButton(
          onPressed: () {
            undoMove();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          style: OutlinedButton.styleFrom(
            shape: StadiumBorder(),
            side: BorderSide(color: Colors.black),
          ),
        ),
      ]),
    );
  }

  Future speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(1);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  Widget openings() {
    return Scaffold(
      body: ListView(children: [
        // SizedBox(height: MediaQuery.of(context).size.height / 50),
        ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
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
            ),
            Center(
                child: Text(query['name'],
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )))
          ],
        ),
        ChessBoard(
          controller: controller,
          boardColor: BoardColor.green,
          boardOrientation: color,
          enableUserMoves: false,
        ),
        Column(children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              query['description'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  undoMove();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: Colors.black),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  speak(query['description']);
                },
                child: Column(children: [
                  Text(
                    "Text-To-Speech",
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(
                    Icons.volume_up,
                    color: Colors.black,
                  )
                ]),
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: Colors.black),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  openingMove();
                  print(moveCount);
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: Colors.black),
                ),
              ),
            ],
          )
        ]),
      ]),
    );
  }

  void chooseColor() {
    AlertDialog alert = AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Choose your color',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ))
        ]),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.teal[400]),
              onPressed: () {
                setState(() {
                  color = PlayerColor.white;
                });
                Navigator.pop(context);
              },
              child: Text(
                'White',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width / 15,
                ),
              )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.teal[400]),
              onPressed: () {
                setState(() {
                  color = PlayerColor.black;
                });
                Navigator.pop(context);
              },
              child: Text(
                'Black',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width / 15,
                ),
              ))
        ]);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget overTheBoard = overTheboard();
    if (query['query'] == "overtheboard" && !chosenColor) {
      Future.delayed(Duration.zero, () {
        WidgetsBinding.instance!.addPostFrameCallback((_) => chooseColor());
      });
      chosenColor = true;
      return overTheBoard;
    } else if (query['query'] == "opening") {
      Widget opening = openings();
      getOpening(query['name']);
      return opening;
    } else {
      return overTheBoard;
    }
  }
}
