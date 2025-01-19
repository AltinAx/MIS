import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key); // Add Key parameter

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month; // Default view
  DateTime _focusedDay = DateTime.now(); // Initially focused day
  DateTime? _selectedDay;

  // Dummy events for demonstration
  final Map<DateTime, List<String>> _events = {
    DateTime(2024, 1, 15): ['Math Exam', 'Physics Exam'],
    DateTime(2024, 1, 20): ['Chemistry Exam'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exam Calendar')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // Update the calendar's focus
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format; // Change calendar format (month/week)
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay; // Update focused day when navigating months
            },
            eventLoader: (day) => _events[day] ?? [], // Load events for the day
          ),
          const SizedBox(height: 8),
          // Display events for the selected day
          Expanded(
            child: ListView(
              children: (_events[_selectedDay] ?? []).map((event) {
                return ListTile(
                  title: Text(event),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
