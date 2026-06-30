import 'package:flutter/material.dart';
import '../../config/app_config.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  final List<Map<String, String>> buildings = const [
    {
      'name': 'Gidan Makama',
      'type': 'Museum / Landmark',
      'hint': 'Near old Kano city area',
    },
    {
      'name': "Emir's Palace",
      'type': 'Administrative Landmark',
      'hint': 'Central Kano heritage location',
    },
    {
      'name': 'Murtala Muhammad Library',
      'type': 'Library',
      'hint': 'Study and research location',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Services'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppConfig.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppConfig.primaryColor),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Campus Location Tracking',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                    'GPS tracking, geofencing, and indoor navigation hints are simulated for demo.'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Geofenced Campus Buildings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...buildings.map((building) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(building['name']!),
                subtitle: Text('${building['type']}\n${building['hint']}'),
                isThreeLine: true,
              ),
            );
          }),
        ],
      ),
    );
  }
}
