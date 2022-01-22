import 'package:chuzzlez/models/puzzles.dart';
import 'package:chuzzlez/providers/puzzles_provider.dart';
import 'package:chuzzlez/services/fire_store_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPuzzle extends StatefulWidget {
  const AddPuzzle({Key? key}) : super(key: key);

  @override
  MyAddPuzzleState createState() {
    return MyAddPuzzleState();
  }
}

class MyAddPuzzleState extends State<AddPuzzle> {
  late FireStoreServices instance = FireStoreServices();
  final _formKey = GlobalKey<FormState>();
  TextEditingController pgnController = new TextEditingController();
  TextEditingController solutionController = new TextEditingController();
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
          Text(
            "Add Puzzle",
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Futura',
              color: Colors.black,
            ),
          ),
          TextFormField(
            controller: pgnController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(50.0),
              ),
              hintText: "Pgn String",
            ),
          ),
          TextFormField(
            controller: solutionController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(50.0),
              ),
              hintText: 'Solution',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (pgnController.text != "" ||
                    solutionController.text.trim() != "") {
                  var length =
                      Provider.of<PuzzlesProvider>(context, listen: false)
                          .getPuzzles
                          .length;
                  instance.addPuzzle(length + 1, pgnController.text.trim(),
                      solutionController.text.trim());
                  Provider.of<PuzzlesProvider>(context, listen: false)
                      .puzzles
                      .puzzlesList
                      .add(Puzzles(
                          levelNumber: length + 1,
                          pgn: pgnController.text.trim(),
                          solution: solutionController.text.trim()));
                  Navigator.pop(context);
                } else {
                  // ERORR MESSAGE
                }
              },
              child: const Text('Submit'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green.shade900),
              )),
        ],
      ),
    ));
  }
}
