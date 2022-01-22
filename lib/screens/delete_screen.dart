import 'package:chuzzlez/providers/opening_provider.dart';
import 'package:chuzzlez/services/fire_store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:provider/provider.dart';

class DeleteScreen extends StatefulWidget {
  DeleteScreen({Key? key}) : super(key: key);

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<DeleteScreen> {
  late FireStoreServices instance = FireStoreServices();
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: Container(
        child: FutureBuilder(
          future: instance.getPosts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index]['firstname'] +
                        "   " +
                        snapshot.data[index]['lastName']),
                    onTap: () {
                      // _deleteUser(index);

                      setState(() {
                        instance.deleteUser(snapshot.data[index]['uid']);
                      });
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
