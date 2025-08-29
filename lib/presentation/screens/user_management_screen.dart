import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_dashboard/data/models/user_service.dart';
import '../../logic/blocs/user_bloc/user_bloc.dart';
import '../../logic/blocs/user_bloc/user_event.dart';
import '../../logic/blocs/user_bloc/user_state.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة المستخدمين')),
      body: BlocProvider(
        create: (context) => UserBloc(UserService())..add(LoadUsers()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UsersLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 24,
                  headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                  columns: const [
                    DataColumn(label: Text('الاسم')),
                    DataColumn(label: Text('البريد')),
                    DataColumn(label: Text('تاريخ التسجيل')),
                    DataColumn(label: Text('الحالة')),
                  ],
                  rows: state.users.map((user) {
                    return DataRow(cells: [
                      DataCell(Text(user.username)),
                      DataCell(Text(user.email)),
                      DataCell(Text(user.createdAt.toLocal().toString().split(' ')[0])),
                      DataCell(Text(user.isBanned ? 'محظور' : 'نشط')),
                    ]);
                  }).toList(),
                ),
              );
            } else if (state is UsersError) {
              return Center(child: Text('حدث خطأ: ${state.message}'));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}