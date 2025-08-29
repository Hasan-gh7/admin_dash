// lib/presentation/screens/moderator_dashboard_screen.dart
import 'package:flutter/material.dart';

class ModeratorDashboardScreen extends StatelessWidget {
  const ModeratorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة المشرف')),
      body: ListView(
        children: const [
          ListTile(title: Text('عرض العقارات')),
          ListTile(title: Text('الإحصائيات')),
        ],
      ),
    );
  }
}