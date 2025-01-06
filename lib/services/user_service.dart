import 'api_client.dart';
import 'dart:convert';

class UserService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response = await _apiClient.get('users');

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch users: ${response.body}');
    }
  }

  Future<void> addUser(String name, double payment, double expense) async {
    final response = await _apiClient.post('users', {
      'name': name,
      'payment': payment,
      'expense': expense,
    });

    if (response.statusCode != 201) {
      throw Exception('Failed to add user: ${response.body}');
    }
  }
}
