import 'package:flutter/material.dart';
import '../../config/app_config.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  bool loading = false;

  final List<Map<String, String>> apiData = [
    {
      'title': 'Campus Announcement API',
      'body': 'Welcome to CampusConnect API service for .',
    },
    {
      'title': 'Student Services API',
      'body': 'Library, timetable, marketplace and attendance data loaded.',
    },
    {
      'title': 'API Base Path',
      'body': '/api/v1/jac/',
    },
  ];

  void _refreshApi() {
    setState(() => loading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('API data refreshed with retry logic simulation'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Services'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshApi,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: AppConfig.secondaryColor.withValues(alpha: 0.15),
            child: const Text(
              'REST API Integration with Retry Logic and Exponential Backoff Simulation',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (loading) const LinearProgressIndicator(),
          Expanded(
            child: ListView.builder(
              itemCount: apiData.length,
              itemBuilder: (context, index) {
                final item = apiData[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.api),
                    title: Text(item['title']!),
                    subtitle: Text(item['body']!),
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
