import 'package:dynamic_ui/core/service_locator.dart';
import 'package:dynamic_ui/core/theme.dart';
import 'package:dynamic_ui/core/config/screen_config.dart';
import 'package:dynamic_ui/screens/first_tab_screen.dart';
import 'package:dynamic_ui/screens/second_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends ConsumerState<App> {

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(themeManagerProvider);
    final screenConfigController = getIt<ScreenConfigController>();
    final backgroundColor = screenConfigController.backgroundColor;

    return MaterialApp(
      title: 'Dynamic UI',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                color: backgroundColor,
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  overlayColor: WidgetStateProperty.all(backgroundColor),
                  unselectedLabelColor: Colors.white.withOpacity(0.5),
                  labelStyle: themeData.textTheme.headlineLarge,
                  tabs: const [
                    Tab(text: 'Dynamic Screen'),
                    Tab(text: 'Tasks'),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    FirstTabScreen(),
                    SecondTabScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}