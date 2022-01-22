// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:chuzzlez/providers/leaderboard_provider.dart';
import 'package:chuzzlez/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chuzzlez/providers/user_provider.dart';
import 'package:chuzzlez/providers/opening_provider.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:chuzzlez/providers/puzzles_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../my_flutter_app_icons.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _selectedIndex = 0;
  var currentLevel = 0;
  var role = false;
  late var url;
  loadData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser!.uid;

      await Provider.of<UserProvider>(context, listen: false).readUser();

      Provider.of<UserProvider>(context, listen: false).getUser.avatarUrl =
          await StorageRepo().getUserProfileImage(
              Provider.of<UserProvider>(context, listen: false).getUser.uid);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        currentLevel = Provider.of<UserProvider>(context, listen: false)
            .getUser
            .currentLevel;
        role =
            Provider.of<UserProvider>(context, listen: false).getUser.isAdmin;
      });
      if (Provider.of<PuzzlesProvider>(context, listen: false).read == false) {
        await Provider.of<PuzzlesProvider>(context, listen: false).readMap();
      }
      if (Provider.of<OpeningProvider>(context, listen: false).read == false) {
        await Provider.of<OpeningProvider>(context, listen: false).readMap();
      }
      Provider.of<LeaderboardProvider>(context, listen: false).readScoreBoard();
      print(Provider.of<LeaderboardProvider>(context, listen: false)
          .leadInstance
          .scoreboard
          .toString());
    }
  }

  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserProvider>(context, listen: false).getUser.isAdmin);
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/home_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (Provider.of<UserProvider>(context, listen: false).getUser.isAdmin ==
            true) ...[
          ListView(children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile',
                      arguments: {'choice': 'my'});
                },
                icon: Icon(Icons.person),
                color: Colors.black,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Chuzzlez',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('The Chess Puzzlez Game',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 42,
                )
              ],
            ),
          ]),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (_selectedIndex == 0) ...[
              SizedBox(width: MediaQuery.of(context).size.width / 1),
              OutlinedButton(
                onPressed: () {
                  Provider.of<UserProvider>(context, listen: false).setOpened();
                  Navigator.pushNamed(context, '/register',
                      arguments: {'role': true});
                },
                child: Column(children: [
                  Text('Add admin',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ]),
                style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(color: Colors.black),
                    backgroundColor: Colors.teal.shade600),
              )
            ],
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            if (_selectedIndex == 1) ...[
              SizedBox(width: MediaQuery.of(context).size.width / 1),
              OutlinedButton(
                onPressed: () {
                  Provider.of<UserProvider>(context, listen: false).setOpened();
                  Navigator.pushNamed(
                    context,
                    '/manage',
                  );
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Manage Puzzles',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ]),
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: Colors.black),
                  backgroundColor: Colors.teal.shade600,
                ),
              )
            ],
          ])
        ] else ...[
          ListView(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile',
                        arguments: {'choice': 'my'});
                  },
                  icon: Icon(Icons.person),
                  color: Colors.black,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Chuzzlez',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 6,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('The Chess Puzzlez Game',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                  )
                ],
              ),
              if (_selectedIndex == 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Provider.of<UserProvider>(context, listen: false)
                            .setOpened();
                        Navigator.pushNamed(context, '/puzzle').then((value) {
                          setState(() {
                            currentLevel = Provider.of<UserProvider>(context,
                                    listen: false)
                                .getUser
                                .currentLevel;
                            Provider.of<LeaderboardProvider>(context,
                                    listen: false)
                                .readScoreBoard();
                          });
                        });
                      },
                      child: Column(children: [
                        Text('Play',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        Text('Level ${currentLevel + 1}',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ))
                      ]),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(color: Colors.black),
                        backgroundColor: Colors.teal.shade600,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/puzzlelist')
                            .then((value) {
                          setState(() {
                            currentLevel = Provider.of<UserProvider>(context,
                                    listen: false)
                                .getUser
                                .currentLevel;
                            Provider.of<LeaderboardProvider>(context,
                                    listen: false)
                                .readScoreBoard();
                          });
                        });
                      },
                      child: Text('Puzzles List',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(color: Colors.black),
                        backgroundColor: Colors.teal.shade600,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/favourite')
                            .then((value) {
                          setState(() {
                            currentLevel = Provider.of<UserProvider>(context,
                                    listen: false)
                                .getUser
                                .currentLevel;
                          });
                        });
                      },
                      child: Text('Favourite Puzzles',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(color: Colors.black),
                        backgroundColor: Colors.teal.shade600,
                      ),
                    ),
                  ],
                ),
              if (_selectedIndex == 1)
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  // alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/board',
                            arguments: {'query': 'overtheboard'});
                      },
                      child: Text('Co-op Match',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(color: Colors.black),
                        backgroundColor: Colors.teal.shade600,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/leaderboard',
                        );
                      },
                      child: Text('Leaderboard',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(color: Colors.black),
                        backgroundColor: Colors.teal.shade600,
                      ),
                    )
                  ],
                ),
              if (_selectedIndex == 2)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/learning',
                            arguments: {'query': 'openings'});
                      },
                      child: Column(children: [
                        Text('Openings',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ]),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(color: Colors.black),
                        backgroundColor: Colors.teal.shade600,
                      ),
                    )
                  ],
                ),
            ],
          )
        ],
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.teal,
        iconSize: MediaQuery.of(context).size.width / 8,
        selectedIconTheme: IconThemeData(
            color: Colors.white, size: MediaQuery.of(context).size.width / 8),
        selectedItemColor: Colors.amberAccent,
        items: <BottomNavigationBarItem>[
          if (Provider.of<UserProvider>(context, listen: false)
                  .getUser
                  .isAdmin ==
              true) ...[
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              label: 'Add admin',
            ),
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.puzzle),
              label: 'Manage puzzles',
            ),
          ] else ...[
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.puzzle),
              label: 'Puzzles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.gamepad),
              label: 'Play',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_sharp),
              label: 'Learning',
            )
          ]
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }
}
