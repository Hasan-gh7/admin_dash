import 'package:flutter/material.dart';

class RecentActivityList extends StatelessWidget {
  final List<String> activities = const [
    "تسجيل مستخدم جديد",
    "تمت الموافقة على عقار جديد",
    "إلغاء مستخدم جديد",
    "تسجيل مستخدم جديد",
  ];

  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: activities.map((activity) {
        return ListTile(
          leading: const Icon(Icons.notifications),
          title: Text(activity),
        );
      }).toList(),
    );
  }
}