import 'package:flutter/material.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Text(
              "حسن غندور",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("لوحة التحكم"),
            onTap: () {
             Navigator.pushNamed(context, '/admin_dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("إدارة المستخدمين"),
            onTap: () {
              Navigator.pushNamed(context, '/users');
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("إدارة العقارات"),
            onTap: () {
              Navigator.pushNamed(context, '/properties');
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online),
            title: const Text("إدارة الحجوزات"),
            onTap: () {
              // يمكنك إضافة التنقل لاحقًا
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("التقارير والإحصائيات"),
            onTap: () {
              // يمكنك إضافة التنقل لاحقًا
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text("المحافظ المالية"),
            onTap: () {
              // يمكنك إضافة التنقل لاحقًا
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("تسجيل الخروج"),
            onTap: () {
              // يمكنك تنفيذ تسجيل الخروج هنا
            },
          ),
        ],
      ),
    );
  }
}