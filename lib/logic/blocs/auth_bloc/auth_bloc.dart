import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_dashboard/data/services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final success = await authService.login(event.email, event.password);
      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("بيانات الدخول غير صحيحة"));
      }
    });
  }
}