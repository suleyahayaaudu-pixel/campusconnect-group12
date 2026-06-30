import 'package:flutter/material.dart';
import '../../config/app_config.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "Exam Reminder",
        "message": "Software Engineering exam starts tomorrow at 9:00 AM",
        "time": "10 mins ago"
      },
      {
        "title": "Assignment Due",
        "message": "CampusConnect assignment submission is tomorrow.",
        "time": "1 hour ago"
      },
      {
        "title": "Marketplace",
        "message": "A new laptop has been posted for sale.",
        "time": "Today"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.notifications),
              ),
              title: Text(item["title"]!),
              subtitle: Text(item["message"]!),
              trailing: Text(
                item["time"]!,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
