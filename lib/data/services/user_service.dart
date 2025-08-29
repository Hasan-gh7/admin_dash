import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:real_estate_dashboard/data/models/user_model.dart';

class UserService {
  final String baseUrl = 'https://9551f9a14c9f.ngrok-free.app/api';

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> data = json['data'];
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('فشل في جلب المستخدمين');
    }
  }

  Future<void> addUser(UserModel user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('فشل في إضافة المستخدم');
    }
  }
}