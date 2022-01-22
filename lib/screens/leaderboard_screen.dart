import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chuzzlez/providers/user_provider.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chuzzlez/providers/user_provider.dart';
import 'package:chuzzlez/providers/leaderboard_provider.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  Leaderboard createState() => Leaderboard();
}

class Leaderboard extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    var map = Provider.of<LeaderboardProvider>(context, listen: false)
        .leadInstance
        .scoreboard;
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.teal.shade400,
          body: ListView(children: <Widget>[
            SizedBox(height: 30),
            Center(
              child: Text(
                'Leaderboard Rankings',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            DataTable(
              dataRowHeight: 100,
              columns: [
                DataColumn(
                    label: Text('Rank',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Name',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Score',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
              ],
              rows: [
                for (int i = 0; i < map.length; i++)
                  DataRow(cells: [
                    DataCell(Row(children: [
                      Text((i + 1).toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg",
                        ),
                        radius: 30.0,
                      ),
                    ])),
                    DataCell(
                      Text(map[i]['Name'],
                          style: TextStyle(fontSize: 18, color: Colors.yellow)),
                    ),
                    DataCell(Row(children: [
                      Text(map[i]['Score'].ceil().toString(),
                          style: TextStyle(fontSize: 18, color: Colors.yellow)),
                      Icon(Icons.done)
                    ])),
                  ]),
              ],
            ),
          ])),
    );
  }
}
