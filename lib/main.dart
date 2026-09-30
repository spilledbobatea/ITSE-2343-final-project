import 'package:flutter/material.dart';
import 'package:friend_grid/home_page.dart';
import 'package:friend_grid/add_friends_page.dart';

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
  int _currentIndex = 0;

  final List<Friend> _friends = [];

  void _addFriend(Friend friend) {
    setState(() {
      _friends.add(friend);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(friends: _friends),
      CurrentPage(text: "Profile"),
      AddFriendPage(onFriendAdded: _addFriend),
      CurrentPage(text: "Edit Schedules"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Friend Grid"),
        actions: [
          Builder(builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: const Icon(Icons.menu)
            ),
          ),
        ],
      ),
      body: pages[_currentIndex],
      // Navigation Drawer
      endDrawer: NavigationDrawer(
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
          Navigator.of(context).pop();
        },
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