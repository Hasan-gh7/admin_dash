import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_dashboard/data/models/user_model.dart';
import 'package:real_estate_dashboard/logic/blocs/user_bloc/user_bloc.dart';
import 'package:real_estate_dashboard/logic/blocs/user_bloc/user_event.dart';
import 'package:real_estate_dashboard/logic/blocs/user_bloc/user_state.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المستخدمون')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user.username),
                  subtitle: Text(user.email),
                  trailing: Icon(
                    user.isBanned ? Icons.block : Icons.check_circle,
                    color: user.isBanned ? Colors.red : Colors.green,
                  ),
                );
              },
            );
          } else if (state is UsersError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('لا توجد بيانات بعد'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newUser = UserModel(
            id: 'uuid-${DateTime.now().millisecondsSinceEpoch}',
            username: 'مستخدم جديد',
            email: 'new@example.com',
            createdAt: DateTime.now(),
            isBanned: false,
          );
          context.read<UserBloc>().add(AddUser(newUser));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}