import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'stats_event.dart';
import 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final String token;

  StatsBloc(this.token) : super(StatsInitial()) {
    on<FetchStatsEvent>((event, emit) async {
      emit(StatsLoading());

      try {
        final propertyResponse = await http.get(
          Uri.parse('https://9551f9a14c9f.ngrok-free.app/api/property/count'),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );

        final userResponse = await http.get(
          Uri.parse('https://9551f9a14c9f.ngrok-free.app/api/user/count'),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );

        // التحقق من نوع المحتوى قبل فك JSON
        final isPropertyJson = propertyResponse.headers['content-type']?.contains('application/json') ?? false;
        final isUserJson = userResponse.headers['content-type']?.contains('application/json') ?? false;

        if (propertyResponse.statusCode == 200 &&
            userResponse.statusCode == 200 &&
            isPropertyJson &&
            isUserJson) {
          final propertyData = json.decode(propertyResponse.body);
          final userData = json.decode(userResponse.body);

          emit(StatsLoaded(
            propertiesCount: propertyData['data'] ?? 0,
            usersCount: userData['data'] ?? 0,
          ));
        } else {
          emit(StatsError('الاستجابة غير صالحة أو ليست بصيغة JSON'));
        }
      } catch (e) {
        emit(StatsError('حدث خطأ أثناء جلب البيانات: ${e.toString()}'));
      }
    });
  }
}