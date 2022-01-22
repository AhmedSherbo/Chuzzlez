import 'package:chuzzlez/providers/opening_provider.dart';
import 'package:chuzzlez/screens/delete_screen.dart';
import 'package:chuzzlez/screens/favourite_screen.dart';
import 'package:chuzzlez/screens/leaderboard_screen.dart';
import 'package:chuzzlez/screens/learning_screen.dart';
import 'package:chuzzlez/screens/login_screen.dart';
import 'package:chuzzlez/screens/friends_screen.dart';
import 'package:chuzzlez/screens/add_puzzle.dart';
import 'package:chuzzlez/screens/openings_form.dart';
import 'package:chuzzlez/screens/settings_screen.dart';
import 'package:chuzzlez/screens/puzzles_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'package:chuzzlez/providers/user_provider.dart';
import 'package:chuzzlez/providers/puzzles_provider.dart';
import 'package:chuzzlez/providers/leaderboard_provider.dart';
import 'screens/puzzle_board_screen.dart';
import 'screens/puzzle_creator_screen.dart';
import 'screens/puzzles_list_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/board_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chuzzlez/screens/profile_screen.dart';
import 'services/authentication_services.dart';
import 'screens/openings_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PuzzlesProvider(),
        ),
        ChangeNotifierProvider(create: (context) => OpeningProvider()),
        ChangeNotifierProvider(create: (context) => LeaderboardProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomeScreen(),
          '/puzzle': (context) => PuzzleBoardScreen(),
          '/puzzlelist': (context) => PuzzleListScreen(),
          '/board': (context) => BoardScreen(),
          '/puzzlecreator': (context) => PuzzleCreator(),
          '/settings': (context) => SettingsScreen(),
          '/profile': (context) => ProfileScreen(),
          '/learning': (context) => LearningScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/leaderboard': (context) => LeaderboardScreen(),
          '/delete': (context) => DeleteScreen(),
          '/manage': (context) => PuzzleManagementScreen(),
          '/friends': (context) => FriendsScreen(),
          '/favourite': (context) => FavouritePuzzleScreen(),
          '/openingsform': (context) => OpeningsForm(),
          '/addpuzzle': (context) => AddPuzzle()
        },
        title: 'Chuzzlez',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF3dc2bf)),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
