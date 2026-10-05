import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
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

  final Map<String, Set<DateTime>> _busySchedules = {
    'Me': {DateTime(2026, 1, 3), DateTime(2026, 1, 17), DateTime(2026, 1, 19), DateTime(2026, 1, 23)},
    'Lily': {DateTime(2026, 1, 6), DateTime(2026, 1, 15), DateTime(2026, 1, 18), DateTime(2026, 1, 22)},
    'Timothy': {DateTime(2026, 1, 7), DateTime(2026, 1, 22), DateTime(2026, 1, 27)}
  };

  void _addFriend(String name) {
    if (name.isNotEmpty && !_busySchedules.containsKey(name)) {
      setState(() {
        _busySchedules[name] = {};
      });
    }
  }

  void _toggleBusyDate(String friend, DateTime date) {
    final key = DateTime(date.year, date.month, date.day);
    setState(() {
      final dates = _busySchedules[friend] ?? {};
      dates.contains(key) ? dates.remove(key) : dates.add(key);
      _busySchedules[friend] = dates;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(busySchedules: _busySchedules),
      AddFriendPage(onFriendAdded: _addFriend),
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
          NavigationDrawerDestination(icon: Icon(Icons.emoji_people_rounded), label: Text("Add Friend")),
        ],
      ),
    );
  }
}