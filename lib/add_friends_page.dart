import 'package:flutter/material.dart';

class Friend {
  final String name;
  final String number;

  Friend({required this.name, required this.number});
}

class AddFriendPage extends StatefulWidget {
  final Function(Friend) onFriendAdded;

  const AddFriendPage({super.key, required this.onFriendAdded});

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  void _submitForm() {
   if (_formKey.currentState!.validate()) {
     final newFriend = Friend(
       name: _nameController.text.trim(),
       number: _numberController.text.trim()
     );

     widget.onFriendAdded(newFriend);

     _nameController.clear();
     _numberController.clear();

     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("${newFriend.name} added!")),
     );
   }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Add a Friend", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Friend's Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person)
              ),
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter a name";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _numberController,
              decoration: const InputDecoration(
                  labelText: "Friend's Number",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person)
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter a number";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.add),
              label: const Text("Add Friend"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12)
              ),
            )
          ],
        )
      ),
    );
  }
}