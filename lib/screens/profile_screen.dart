import 'dart:io';

import 'package:chuzzlez/services/storage_services.dart';
import 'package:chuzzlez/services/fire_store_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chuzzlez/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  late FireStoreServices instance = FireStoreServices();
  File? imageFile;
  Future pickImage() async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      try {
        imageFile = File(pickedFile!.path);
        print("Image uploaded");
      } catch (e) {
        print(e);
      }
    });
  }

  getUrl() async {
    String file = await StorageRepo().getUserProfileImage(
        Provider.of<UserProvider>(context, listen: false).getUser.uid);
    return file;
  }

  late Map query =
      ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;

  Widget otherProfile() {
    var _user = Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Row(children: [
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
            )
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.teal.shade400, Colors.teal.shade600])),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg",
                        ),
                        radius: MediaQuery.of(context).size.height / 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Text(
                        query['choice'] == 'other'
                            ? query['map']['firstname']
                            : 'aara',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 13,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 30,
                          vertical: MediaQuery.of(context).size.height / 70,
                        ),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.teal.shade200,
                        elevation: MediaQuery.of(context).size.height / 50,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 10,
                            vertical: MediaQuery.of(context).size.height / 30,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Level",
                                      style: TextStyle(
                                        color: Colors.teal.shade400,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100,
                                    ),
                                    Text(
                                      query['choice'] == 'other'
                                          ? query['map']['currentLevel']
                                              .toString()
                                          : 'aara',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        color: Colors.teal.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Won",
                                      style: TextStyle(
                                        color: Colors.teal.shade400,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100,
                                    ),
                                    Text(
                                      query['choice'] == 'other'
                                          ? query['map']['completedLevels']
                                              .length
                                              .toString()
                                          : 'aara',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        color: Colors.teal.shade400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Games",
                                      style: TextStyle(
                                        color: Colors.teal.shade400,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100,
                                    ),
                                    Text(
                                      "NA",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        color: Colors.teal.shade400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Container(
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: 20.0,
          ),
          if (query['choice'] == "other")
            if (!_user.friends.contains(query['map']['email'])) ...[
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    Provider.of<UserProvider>(context, listen: false)
                        .getUser
                        .friends
                        .add(query['map']['email']);
                    Navigator.pushNamed(context, '/friends', arguments: {
                      'friends':
                          Provider.of<UserProvider>(context, listen: false)
                              .getUser
                              .friends,
                      'choice': 'add',
                      'email': query['map']['email']
                    });
                  });
                },
                child: Column(children: [
                  Text('Add Friend',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ]),
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: Colors.black),
                ),
              )
            ],
        ],
      ),
    );
  }

  Widget myProfile() {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Row(children: [
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
            )
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.teal.shade400, Colors.teal.shade600])),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          try {
                            await pickImage();
                            await StorageRepo().uploadFile(imageFile!);
                            var url = await StorageRepo().getUserProfileImage(
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .getUser
                                    .uid);
                            setState(() {
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser
                                  .avatarUrl = url;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            Provider.of<UserProvider>(context, listen: false)
                                .getUser
                                .avatarUrl,
                          ),
                          radius: MediaQuery.of(context).size.height / 10,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Text(
                        Provider.of<UserProvider>(context, listen: false)
                            .getUser
                            .firstName,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 13,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 30,
                          vertical: MediaQuery.of(context).size.height / 70,
                        ),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.teal.shade200,
                        elevation: MediaQuery.of(context).size.height / 50,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 10,
                            vertical: MediaQuery.of(context).size.height / 30,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Level",
                                      style: TextStyle(
                                        color: Colors.teal.shade400,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100,
                                    ),
                                    Text(
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .getUser
                                          .currentLevel
                                          .toString(),
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        color: Colors.teal.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Won",
                                      style: TextStyle(
                                        color: Colors.teal.shade400,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100,
                                    ),
                                    Text(
                                      "${Provider.of<UserProvider>(context, listen: false).getUser.completedLevels.length}",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        color: Colors.teal.shade400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Games",
                                      style: TextStyle(
                                        color: Colors.teal.shade400,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100,
                                    ),
                                    Text(
                                      "NA",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        color: Colors.teal.shade400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Container(
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: 20.0,
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/friends', arguments: {
                'friends': Provider.of<UserProvider>(context, listen: false)
                    .getUser
                    .friends,
                'choice': 'viewFriends'
              });
            },
            child: Column(children: [
              Text('My Friends',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ]),
            style: OutlinedButton.styleFrom(
              shape: StadiumBorder(),
              side: BorderSide(color: Colors.black),
            ),
          ),
          if (FirebaseAuth.instance.currentUser != null)
            OutlinedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed out");
                  Provider.of<UserProvider>(context, listen: false).logOut();
                  Navigator.pushNamed(context, '/home', arguments: "logout");
                  print(FirebaseAuth.instance.currentUser.toString());
                }, onError: (e) {
                  print("signed out error" + e);
                });
              },
              child: Text('Log Out',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
                side: BorderSide(color: Colors.black),
              ),
            )
          else
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Log In',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
                side: BorderSide(color: Colors.black),
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget my = myProfile();
    Widget other = otherProfile();
    var _user = Provider.of<UserProvider>(context, listen: false).getUser;
    if (query['choice'] == "my") {
      return my;
    } else if (query['choice'] == "other") {
      return other;
    }
    throw '';
  }
}
