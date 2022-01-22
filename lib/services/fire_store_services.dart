import 'package:chuzzlez/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chuzzlez/providers/user_provider.dart';
import 'package:chuzzlez/providers/puzzles_provider.dart';

import 'package:chuzzlez/screens/settings_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  Query levelsCollection =
      FirebaseFirestore.instance.collection('Levels').orderBy('levelNumber');

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference openingsCollection =
      FirebaseFirestore.instance.collection('openings');
  Query scoreReference = FirebaseFirestore.instance
      .collection("users")
      .orderBy('total_score', descending: true);

  // String? uid = FirebaseAuth.instance.currentUser?.uid;
  Future<List> getLevels() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await levelsCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  Future<List> getUsers() async {
    QuerySnapshot querySnapshot = await usersCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  Future<DocumentSnapshot> readUser() async {
    DocumentSnapshot documentSnapshot =
        await usersCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();
    return documentSnapshot;
  }

  Future<DocumentSnapshot> readAllUsers() async {
    DocumentSnapshot documentSnapshot = await usersCollection.doc().get();
    return documentSnapshot;
  }

  Future<List> getOpenings() async {
    QuerySnapshot querySnapshot = await openingsCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  updateClevel(int level) {
    usersCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'currentLevel': level});
  }

  updateuScore(int score) {
    usersCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'total_score': score});
  }

  updateCompletedLevels(List levels) {
    usersCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'completedLevels': levels});
  }

  updatefavouriteLevels(List levels) {
    usersCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'fav_puzzles': levels});
  }

  getScores() async {
    QuerySnapshot querySnapshot = await scoreReference.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  Future getPosts() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var querySnapshots = await collection.get();

    return querySnapshots.docs.toList();
  }

  deleteUser(docID) {
    FirebaseFirestore.instance.collection('users').doc(docID).delete();
  }

  deletePuzzle(puzzleID) {
    FirebaseFirestore.instance.collection('Levels').doc(puzzleID).delete();
  }

  addPuzzle(int levelNumber, String pgn, String solution) async {
    var map = {'levelNumber': levelNumber, 'pgn': pgn, 'solution': solution};

    await FirebaseFirestore.instance
        .collection("Levels")
        .doc(levelNumber.toString())
        .set(map);
  }
}
