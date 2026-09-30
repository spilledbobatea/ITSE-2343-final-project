import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friend Grid',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Friend Grid'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  final List<Widget> _pages = [
    CurrentPage(text: "Home"),
    CurrentPage(text: "Profile"),
    CurrentPage(text: "Add Friends"),
    CurrentPage(text: "Edit Schedules"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Friend Grid")
      ),
      body: _pages[_currentIndex],
      // Navigation Drawer
      endDrawer: NavigationDrawer(
        onDestinationSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
          _scaffoldKey.currentState?.closeEndDrawer();
        },
        selectedIndex: _currentIndex,
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Friend Grid", style: TextStyle(fontSize: 30))
              ],
            ),
          ),
          NavigationDrawerDestination(icon: Icon(Icons.home_rounded), label: Text("Home")),
          NavigationDrawerDestination(icon: Icon(Icons.account_circle_rounded), label: Text("Profile")),
          NavigationDrawerDestination(icon: Icon(Icons.emoji_people_rounded), label: Text("Add Friend")),
          NavigationDrawerDestination(icon: Icon(Icons.schedule_rounded), label: Text("Edit Schedules")),
        ],
      ),
    );
  }
}

class CurrentPage extends StatelessWidget {
  final String text;
  const CurrentPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}