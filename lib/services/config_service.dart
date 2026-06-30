import 'dart:convert';
import 'package:flutter/services.dart';

class ConfigService {
  static Map<String, dynamic>? _config;

  static Future<void> load() async {
    final jsonString = await rootBundle.loadString('lib/assets/config.json');
    _config = jsonDecode(jsonString);

    if (campusCode != 'CAM-JAC-12' ||
        apiBasePath != '/api/v1/jac/' ||
        group != 12) {
      throw Exception(
        'FATAL CONFIG ERROR: Invalid Group 12 configuration.',
      );
    }
  }

  static int get group => _config?['group'] ?? 0;
  static String get campusCode => _config?['campusCode'] ?? '';
  static String get campusName => _config?['campusName'] ?? '';
  static String get primaryColor => _config?['primaryColor'] ?? '';
  static String get secondaryColor => _config?['secondaryColor'] ?? '';
  static String get apiBasePath => _config?['apiBasePath'] ?? '';
  static String get uniqueConstraint => _config?['uniqueConstraint'] ?? '';
}
