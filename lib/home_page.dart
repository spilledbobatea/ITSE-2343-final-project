import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'add_friends_page.dart';

class HomePage extends StatefulWidget {
  final Map<String, Set<DateTime>> busySchedules;
  const HomePage({super.key, required this.busySchedules});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _focusedDay = DateTime(2026, 1, 1);
  String? _selectedFriendFilter;

  bool _isDayBlocked(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);

    // Drop down selection
    if (_selectedFriendFilter !=null) {
      // selected friends
      return widget.busySchedules[_selectedFriendFilter]?.contains(key) ?? false;
    } else {
      // all friends
      for (final dates in widget.busySchedules.values) {
        if (dates.contains(key)) return true;
      }
      return false;
    }
  }

  List<DateTime> _getSuggestions() {
    final List<DateTime> freeDays = [];
    final start = DateTime(2026, 1, 1);

    for (int i = 0; i < 31; i ++) {
      final checkDate = start.add(Duration(days: i));
      if (!_isDayBlocked(checkDate)) {
        freeDays.add(checkDate);
      }
    }
    return freeDays;
  }

  @override
  Widget build(BuildContext context) {
    final friends = widget.busySchedules.keys.toList();
    final suggestedDates = _getSuggestions();
    return SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2026, 1, 1),
            lastDay: DateTime(2026, 1, 31),
            focusedDay: _focusedDay,
            onPageChanged: (focused) => _focusedDay = focused,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focused) {
                final blocked = _isDayBlocked(day);
                if (!blocked) return null;

                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.red.shade200,
                    shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
          const Divider(),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  DropdownButton<String?>(
                      value: _selectedFriendFilter,
                      hint: const Text("All"),
                      items: [
                        const DropdownMenuItem<String?>(
                            value: null,
                            child: Text("All")
                        ),
                        ...friends.map((friend) {
                            return DropdownMenuItem<String?>(
                              value: friend,
                              child: Text(friend),
                            );
                        }),
                      ],
                      onChanged: (value){
                        setState(() {
                          _selectedFriendFilter = value;
                        });
                      })
                ],
              ),
          ),
          const SizedBox(height: 12),

          Text(
            _selectedFriendFilter == null
            ? "Recommended group days:"
              : "Free days for $_selectedFriendFilter:",
            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),
          ),
          const SizedBox(height: 8),
          if (suggestedDates.isEmpty) ...[
            const Text("No free days this month.", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          ] else ...[
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: suggestedDates.map((date) {
                return Chip(
                  avatar: const Icon(Icons.check, size: 16, color: Colors.lightGreen),
                  label: Text("${date.month}/${date.day}/${date.year}"),
                  backgroundColor: Colors.green.shade50,
                );
              }).toList(),
            ),
          ]
        ],
      ),
    );
  }
}