import 'package:dynamic_ui/core/theme.dart';
import 'package:dynamic_ui/screens/first_tab_screen.dart';
import 'package:dynamic_ui/screens/second_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(themeManagerProvider);
    return MaterialApp(
      title: 'Dynamic UI',
      theme: themeData,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: themeData.primaryColor,
            bottom: TabBar(
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.5),
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