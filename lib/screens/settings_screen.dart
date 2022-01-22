import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chuzzlez/providers/user_provider.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chuzzlez/providers/user_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var outputButton;
    if (FirebaseAuth.instance.currentUser != null) {
      outputButton = OutlinedButton(
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
      );
    } else {
      outputButton = OutlinedButton(
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
      );
    }
    return Scaffold(
        body: Column(children: [
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
      SizedBox(
        height: MediaQuery.of(context).size.height / 35,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          new Container(
            decoration: BoxDecoration(color: Colors.teal.shade400),
            width: MediaQuery.of(context).size.width,
            child: Text('Settings',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 7,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 7),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text('Theme',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height / 23,
            )),
        SizedBox(width: MediaQuery.of(context).size.width / 2.3),
        SizedBox(
          width: MediaQuery.of(context).size.width / 15,
          height: MediaQuery.of(context).size.height / 30,
          child:
              const DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 15),
        SizedBox(
          width: MediaQuery.of(context).size.width / 15,
          height: MediaQuery.of(context).size.height / 30,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.black, width: 3))),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 15),
        SizedBox(
          width: MediaQuery.of(context).size.width / 15,
          height: MediaQuery.of(context).size.height / 30,
          child: const DecoratedBox(
              decoration: BoxDecoration(color: Colors.yellow)),
        )
      ]),
      SizedBox(height: MediaQuery.of(context).size.height / 10),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text('Auto-load Puzzlez',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )),
        SizedBox(width: MediaQuery.of(context).size.width / 4),
        Switch(
          onChanged: null,
          value: false,
          activeColor: Colors.blue,
          activeTrackColor: Colors.yellow,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey,
        ),
      ]),
      SizedBox(height: 50),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text('Volume',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )),
        SizedBox(width: MediaQuery.of(context).size.width / 1.8),
        IconButton(
            onPressed: null,
            icon: Icon(
              Icons.volume_up,
              size: 40,
            ))
      ]),
      SizedBox(height: MediaQuery.of(context).size.height / 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [outputButton],
      )
    ]));
  }
}
