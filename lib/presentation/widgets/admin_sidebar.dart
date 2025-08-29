import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_dashboard/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_estate_dashboard/logic/blocs/auth_bloc/auth_event.dart';

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
            leading: const Icon(Icons.logout),
            title: const Text("تسجيل الخروج"),
            onTap: () {
              Navigator.of(context).pop();
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),          ListTile(
            leading: const Icon(Icons.book_online),
            title: const Text("إدارة الحجوزات"),
            onTap: () {
              Navigator.pushNamed(context, '/bookings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("التقارير والإحصائيات"),
            onTap: () {
              Navigator.pushNamed(context, '/reports');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text("المحافظ المالية"),
            onTap: () {
              Navigator.pushNamed(context, '/wallets');
            },
          ),
        ],
      ),
    );
  }
}