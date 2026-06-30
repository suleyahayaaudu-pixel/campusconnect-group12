import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../services/database_service.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({super.key});

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  List<Map<String, dynamic>> cachedData = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await DatabaseService.seedInitialData();
    final data = await DatabaseService.getOfflineItems();

    if (!mounted) return;

    setState(() {
      cachedData = data;
      loading = false;
    });
  }

  Future<void> _addOfflineItem() async {
    await DatabaseService.insertOfflineItem(
      'Queue',
      'Offline action saved at ${TimeOfDay.now().format(context)}',
      'Pending Sync',
    );

    await _loadData();
  }

  Future<void> _syncData() async {
    await DatabaseService.syncAllItems();
    await _loadData();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('SQLite offline queue synced successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pending =
        cachedData.where((e) => e['status'] == 'Pending Sync').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Support'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: _syncData,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        onPressed: _addOfflineItem,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: AppConfig.secondaryColor.withValues(alpha: 0.15),
            child: Text(
              'SQLite Local Cache Active | Pending Sync: $pending',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (loading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: cachedData.length,
                itemBuilder: (context, index) {
                  final item = cachedData[index];

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: const Icon(Icons.storage),
                      title: Text(item['type']),
                      subtitle: Text(item['data']),
                      trailing: Text(item['status']),
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
