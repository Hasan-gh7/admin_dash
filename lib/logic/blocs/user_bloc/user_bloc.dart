import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_dashboard/data/models/user_service.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc(this.userService) : super(UsersInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UsersLoading());
      try {
        final users = await userService.fetchUsers();
        emit(UsersLoaded(users));
      } catch (e) {
        emit(UsersError('فشل تحميل المستخدمين: ${e.toString()}'));
      }
    });

    on<AddUser>((event, emit) async {
      emit(UsersLoading());
      try {
        await userService.addUser(event.user);
        final users = await userService.fetchUsers();
        emit(UsersLoaded(users));
      } catch (e) {
        emit(UsersError('فشل إضافة المستخدم: ${e.toString()}'));
      }
    });
  }
}