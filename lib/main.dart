import 'dart:convert';

import 'package:dynamic_ui/firebase_options.dart';
import 'package:dynamic_ui/models/screen_config.dart';
import 'package:dynamic_ui/screens/first_tab_screen.dart';
import 'package:dynamic_ui/screens/second_tab_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic UI',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Dynamic Screen'),
                Tab(text: 'Tasks'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FirstTabScreen(),
              SecondTabScreen(),
            ],
          ),
        ),
      ),
    );
  }
}


