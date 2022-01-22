import 'package:chuzzlez/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:chuzzlez/models/puzzles.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:chuzzlez/providers/puzzles_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chuzzlez/services/fire_store_services.dart';

class FriendsScreen extends StatefulWidget {
  FriendsScreen({Key? key}) : super(key: key);
//
  @override
  _FriendState createState() => _FriendState();
}

class _FriendState extends State<FriendsScreen> {
  late FireStoreServices instance = FireStoreServices();
  final _auth = FirebaseAuth.instance;
  late Map query =
      ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;

  @override
  void initState() {
    super.initState();
  }

  returnUsers() async {
    var map = await instance.getPosts();
    List<dynamic> map2 = map;
    return map;
  }

  Widget viewFriends() {
    var _user = Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: 35,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('My Friends',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
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
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/friends',
                        arguments: {'choice': 'addFriends'});
                  },
                  child: Icon(
                    Icons.person_add,
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
        crossAxisCount: 1,
        childAspectRatio: 10 / 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 1.0,
        children: [
          if (query['choice'] != 'addFriends')
            for (int i = 0; i < query['friends'].length; i++)
              ListView(
                padding: const EdgeInsets.all(0),
                children: <Widget>[
                  Container(
                      child: ListTile(
                    title: Text(query['friends'][i]),
                    dense: true,
                    trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () => goToProfile(query['friends'][i]),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text("View Profile")
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () => setState(() {
                                  deleteFriend(query['friends'][i]);
                                }),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text("Delete")
                                  ],
                                ),
                              ),
                            ]),
                    tileColor: Colors.blueGrey,
                    onTap: () => print(query['friends'][0]),
                  )),
                ],
              )
        ],
      ))
    ]));
  }

  Widget addFriends() {
    bool searching = false;
    final searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          trailing: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              searchFriends(searchController.text);
            },
          ),
          leading: OutlinedButton(
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
          title: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for friends...',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              )),
        ),
        automaticallyImplyLeading: false,
        actions: [],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 10 / 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 1.0,
            children: [],
          ))
        ],
      ),
    );
  }

  Future<void> deleteFriend(String email) async {
    var _user = Provider.of<UserProvider>(context, listen: false).getUser;
    var arr = [];
    arr.add(email);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore
        .collection("users")
        .doc(_user.uid)
        .update({'friends': FieldValue.arrayRemove(arr)});
  }

  Future<void> searchFriends(String email) async {
    print(email);
    bool found = false;
    var map = await instance.getUsers();
    for (int i = 0; i < map.length; i++) {
      print(map[i]['email']);
      if (email == map[i]['email']) {
        // print(map[i]);
        Navigator.pushNamed(context, '/profile',
            arguments: {'choice': 'other', 'email': email, 'map': map[i]});
        found = true;
      }
    }
    if (!found) {
      Fluttertoast.showToast(msg: 'User does not exist.');
    }
  }

  Future<void> addFriend(String email) async {
    var _user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['email'] = email;

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore.collection("users").doc(_user.uid).update({
      'friends': FieldValue.arrayUnion([email])
    });
    print(_user);
    print(email);
    print(_user);
  }

  Future<void> goToProfile(String email) async {
    print(email);
    bool found = false;
    var map = await instance.getUsers();
    for (int i = 0; i < map.length; i++) {
      print(map[i]['email']);
      if (email == map[i]['email']) {
        // print(map[i]);
        Navigator.pushNamed(context, '/profile',
            arguments: {'choice': 'other', 'email': email, 'map': map[i]});
        found = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget view = viewFriends();
    Widget add = addFriends();
    var _user = Provider.of<UserProvider>(context, listen: false).getUser;
    if (query['choice'] == "viewFriends") {
      return view;
    } else if (query['choice'] == "addFriends") {
      return add;
    } else if (query['choice'] == "add") {
      addFriend(query['email']);
      return view;
    }
    throw '';
  }
}
