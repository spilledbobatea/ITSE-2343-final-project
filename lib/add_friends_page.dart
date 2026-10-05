import 'package:flutter/material.dart';

class AddFriendPage extends StatefulWidget {
  final Function(String, DateTime?) onFriendAdded;

  const AddFriendPage({super.key, required this.onFriendAdded});

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final _nameController = TextEditingController();
  DateTime? _selectedBday;

  Future<void> _pickBday(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2026, 1, 1),
        firstDate: DateTime(2026, 1, 1),
        lastDate: DateTime(2026, 1, 31),
    );
    if (picked !=null) {
      setState(() {
        _selectedBday = picked;
      });
    }
  }

  void _submit() {
    final name = _nameController.text.trim();
   if (name.isNotEmpty) {
     widget.onFriendAdded(name, _selectedBday);
     _nameController.clear();
     setState(() {
       _selectedBday = null;
     });
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("Added $name to your friends!")),
     );
   }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Friend name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            Row (
              children: [
                Expanded(
                    child: Text(
                      _selectedBday == null
                      ? "No birthday selected"
                      : "Birthday: ${_selectedBday!.month}/${_selectedBday!.day}/${_selectedBday!.year}",
                      style: const TextStyle(fontSize: 16),
                    ),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.cake_rounded),
                  label: const Text("Pick birthday"),
                  onPressed: () => _pickBday(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Add Friend"),
                onPressed: _submit
              ),
            )
        ]
      )
    );
  }
}