import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/property_model.dart';

class PropertyService {
  final String baseUrl = 'https://9551f9a14c9f.ngrok-free.app/api';

  Future<List<PropertyModel>> fetchProperties() async {
    final response = await http.get(Uri.parse('$baseUrl/properties'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => PropertyModel.fromJson(json)).toList();
    } else {
      throw Exception('فشل في جلب العقارات');
    }
  }

  Future<void> addProperty(PropertyModel property) async {
    final response = await http.post(
      Uri.parse('$baseUrl/properties'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(property.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('فشل في إضافة العقار');
    }
  }
}