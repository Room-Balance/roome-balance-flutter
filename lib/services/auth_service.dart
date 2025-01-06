import 'api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<void> login(String email, String password) async {
    final response = await _apiClient.post('auth/login', {
      'email': email,
      'password': password,
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<void> register(String name, String email, String password) async {
    final response = await _apiClient.post('auth/register', {
      'name': name,
      'email': email,
      'password': password,
    });

    if (response.statusCode != 201) {
      throw Exception('Failed to register: ${response.body}');
    }
  }
}
