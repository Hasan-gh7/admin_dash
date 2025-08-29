import 'package:real_estate_dashboard/data/models/user_model.dart';

abstract class UserState {}

class UsersInitial extends UserState {}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<UserModel> users;

  UsersLoaded(this.users);
}

class UserAdded extends UserState {}

class UsersError extends UserState {
  final String message;

  UsersError(this.message);
}