import 'package:flutter/material.dart';
import '../../config/app_config.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<Map<String, dynamic>> students = [
    {
      'name': 'Musa Gidan Makama',
      'dept': 'Software Engineering',
      'present': true
    },
    {'name': 'Fatima Emir Palace', 'dept': 'Cyber Security', 'present': false},
    {'name': 'Ibrahim Murtala', 'dept': 'Computer Science', 'present': true},
    {
      'name': 'Aisha Kano Central',
      'dept': 'Information Technology',
      'present': true
    },
  ];

  int get presentCount => students.where((s) => s['present'] == true).length;

  @override
  Widget build(BuildContext context) {
    final percent = ((presentCount / students.length) * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Tracker'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            color: AppConfig.secondaryColor.withValues(alpha: 0.15),
            child: Text(
              'BLE Beacon Simulation: $presentCount/${students.length} present ($percent%)',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: SwitchListTile(
                    secondary: CircleAvatar(
                      backgroundColor: student['present']
                          ? Colors.green.withValues(alpha: 0.2)
                          : Colors.red.withValues(alpha: 0.2),
                      child: Icon(
                        student['present'] ? Icons.check : Icons.close,
                        color: student['present'] ? Colors.green : Colors.red,
                      ),
                    ),
                    title: Text(student['name']),
                    subtitle: Text(
                        '${student['dept']}\nMinimum stay: 10+ minutes verified'),
                    isThreeLine: true,
                    value: student['present'],
                    onChanged: (value) {
                      setState(() {
                        student['present'] = value;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
