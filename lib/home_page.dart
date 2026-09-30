import 'package:flutter/material.dart';
import 'add_friends_page.dart';

class HomePage extends StatelessWidget{
  final List<Friend> friends;

  const HomePage({super.key, required this.friends});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(friend.name[0].toUpperCase()),
          ),
          title: Text(friend.name),
          subtitle: Text(friend.number),
        );
      }
    );
  }
}