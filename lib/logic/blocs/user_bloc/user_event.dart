
import 'package:real_estate_dashboard/data/models/user_model.dart';

abstract class UserEvent {}

class LoadUsers extends UserEvent {}

class AddUser extends UserEvent {
  final UserModel user;

  AddUser(this.user);
}