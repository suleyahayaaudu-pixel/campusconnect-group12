import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;
  static final List<Map<String, dynamic>> _webItems = [];

  static Future<void> seedInitialData() async {
    final items = await getOfflineItems();

    if (items.isEmpty) {
      await insertOfflineItem('User', 'Yahaya Sule Audu - Software Engineering', 'Cached');
      await insertOfflineItem('User', 'Student A - Cyber Security', 'Cached');
      await insertOfflineItem('User', 'Student B - Computer Science', 'Cached');
      await insertOfflineItem('Location', 'ICT Centre - CAM-JAC-12', 'Cached');
      await insertOfflineItem('Location', 'Faculty of Computing - CAM-JAC-12', 'Cached');
      await insertOfflineItem('Event', 'CSE 413 Mobile App Demo', 'Cached');
      await insertOfflineItem('Message', 'Welcome to CampusConnect Group 12', 'Synced');
    }
  }

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'campusconnect_group12.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE offline_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT NOT NULL,
            data TEXT NOT NULL,
            status TEXT NOT NULL,
            campus_code TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<int> insertOfflineItem(
    String type,
    String data,
    String status,
  ) async {
    final item = {
      'id': _webItems.length + 1,
      'type': type,
      'data': data,
      'status': status,
      'campus_code': 'CAM-JAC-12',
      'created_at': DateTime.now().toIso8601String(),
    };

    if (kIsWeb) {
      _webItems.insert(0, item);
      return item['id'] as int;
    }

    final db = await database;
    return db.insert('offline_items', item);
  }

  static Future<List<Map<String, dynamic>>> getOfflineItems() async {
    if (kIsWeb) {
      return List<Map<String, dynamic>>.from(_webItems);
    }

    final db = await database;
    return db.query('offline_items', orderBy: 'id DESC');
  }

  static Future<void> syncAllItems() async {
    if (kIsWeb) {
      for (final item in _webItems) {
        if (item['status'] == 'Pending Sync') {
          item['status'] = 'Synced';
        }
      }
      return;
    }

    final db = await database;
    await db.update(
      'offline_items',
      {'status': 'Synced'},
      where: 'status = ?',
      whereArgs: ['Pending Sync'],
    );
  }
}