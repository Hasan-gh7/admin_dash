import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import '../widgets/recent_activity_list.dart';
import '../widgets/admin_sidebar.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminSidebar(),
      appBar: AppBar(
        title: const Text("لوحة التحكم المسؤول"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                StatCard(title: "الإيرادات", value: "16,650", icon: Icons.attach_money),
                StatCard(title: "الحجوزات النشطة", value: "234", icon: Icons.event_available),
                StatCard(title: "عدد العقارات", value: "1,250", icon: Icons.home_work),
                StatCard(title: "عدد المستخدمين", value: "5,932", icon: Icons.people),
              ],
            ),
            const SizedBox(height: 32),
            const Text("الرسوم البيانية", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

         //  const Placeholder(fallbackHeight: 200),

            const SizedBox(height: 32),
            const Text("الأنشطة الأخيرة", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const RecentActivityList(),
          ],
        ),
      ),
    );
  }
}