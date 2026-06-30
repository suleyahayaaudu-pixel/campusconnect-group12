import 'package:flutter/material.dart';

class AppConfig {
  static const int groupNumber = 12;

  static const String campusCode = 'CAM-JAC-12';
  static const String apiBasePath = '/api/v1/jac/';
  static const String campusName = 'JAC Campus';

  static const String uniqueConstraint = 'Inactive session timeout: 5 minutes';

  static const int inactiveSessionTimeoutMinutes = 5;

  static const Color primaryColor = Color(0xFF263238);
  static const Color secondaryColor = Color(0xFFFF9100);

  static const List<String> buildings = [
    'ICT Centre',
    'Faculty of Computing',
    'University Library',
    'Senate Building',
    'Lecture Theatre A',
  ];

  static void verify() {
    if (groupNumber != 12 ||
        campusCode != 'CAM-JAC-12' ||
        apiBasePath != '/api/v1/jac/') {
      throw Exception(
        'FATAL CONFIG ERROR: This build must be Group 12, '
        'Campus CAM-JAC-12, API /api/v1/jac/.',
      );
    }
  }
}
