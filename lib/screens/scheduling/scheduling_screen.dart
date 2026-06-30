import 'package:flutter/material.dart';
import '../../config/app_config.dart';

class SchedulingScreen extends StatelessWidget {
  const SchedulingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final schedules = [
      {
        "course": "Software Engineering",
        "venue": "Lecture Hall A",
        "time": "Monday 9:00 AM"
      },
      {
        "course": "Cyber Security",
        "venue": "Lab 2",
        "time": "Tuesday 11:00 AM"
      },
      {
        "course": "Project Supervision",
        "venue": "Department Office",
        "time": "Friday 2:00 PM"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Scheduling"),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final item = schedules[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.calendar_today),
              ),
              title: Text(item["course"]!),
              subtitle: Text(item["venue"]!),
              trailing: Text(item["time"]!),
            ),
          );
        },
      ),
    );
  }
}
