import 'package:chuzzlez/providers/user_provider.dart';
import 'package:chuzzlez/screens/openings_form.dart';
import 'package:flutter/material.dart';
import 'package:chuzzlez/models/puzzles.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:provider/provider.dart';
import 'package:chuzzlez/providers/opening_provider.dart';
import 'package:chuzzlez/providers/puzzles_provider.dart';

class LearningScreen extends StatefulWidget {
  LearningScreen({Key? key}) : super(key: key);

  @override
  _LearningState createState() => _LearningState();
}

class _LearningState extends State<LearningScreen> {
  ChessBoardController controller = ChessBoardController();
  late Map query =
      ModalRoute.of(context)?.settings.arguments as Map<String, String>;

  @override
  void initState() {
    super.initState();
  }

  Widget openings() {
    int number = Provider.of<OpeningProvider>(context, listen: false).getCount;
    var list = Provider.of<OpeningProvider>(context, listen: false).getOpenings;
    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 14,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Openings',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 12,
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
                horizontal: MediaQuery.of(context).size.width / 40,
              ),
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
      ]),
      Flexible(
          child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 10 / 4,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        children: [
          for (int i = 0; i < number; i++)
            ListView(
              children: <Widget>[
                Container(
                    child: ListTile(
                  horizontalTitleGap: 1,
                  title: Text(list[i].openingName),
                  dense: true,
                  leading: Image(
                    image: AssetImage('images/chess_piece_pawn.png'),
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  tileColor: Colors.blueGrey,
                  onTap: () =>
                      Navigator.pushNamed(context, '/board', arguments: {
                    'query': 'opening',
                    'name': list[i].openingName,
                    'description': list[i].description
                  }),
                )),
              ],
            )
        ],
      ))
    ]));
  }

  Widget concepts() {
    return Scaffold(
      body: ListView(children: [
        SizedBox(height: 7),
        Center(
            child: Text('Learning',
                style: TextStyle(
                  fontSize: 20,
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
          ],
        ),
        SizedBox(
          height: 20,
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/learning',
                    arguments: {'query': 'openings'});
              },
              child: Text('Openings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
                side: BorderSide(color: Colors.black),
              ),
            ),
          ],
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget concept = concepts();
    Widget opening = openings();
    if (query['query'] == "concepts") {
      return concept;
    } else if (query['query'] == "openings") {
      return opening;
    }
    throw '';
  }
}
