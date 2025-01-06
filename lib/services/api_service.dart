import 'dart:convert'; // JSON handling
import 'package:http/http.dart' as http;
import 'cache_service.dart';

class ApiService {
  final String baseUrl = 'http://localhost:8080/api'; // Update with your backend URL
  final CacheService _cacheService = CacheService();

  /// Fetch user data and cache it
  Future<Map<String, dynamic>?> getUserData(String idToken) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/data'),
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        await _cacheService.writeCache(data); // Cache the data
        return data;
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  /// Get cached user data
  Future<Map<String, dynamic>?> getCachedUserData() async {
    return await _cacheService.readCache();
  }

  /// Refresh cache by fetching the latest data
  Future<void> refreshCache(String idToken) async {
    final data = await getUserData(idToken);
    if (data != null) {
      print('Cache refreshed successfully');
    } else {
      print('Failed to refresh cache');
    }
  }

  /// Generalized GET method
  Future<http.Response?> get(String endpoint, String idToken) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      print('GET request error: $e');
      return null;
    }
  }

  /// Generalized POST method
  Future<http.Response?> post(String endpoint, Map<String, dynamic> data, String idToken) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      return response;
    } catch (e) {
      print('POST request error: $e');
      return null;
    }
  }

  /// Generalized PUT method
  Future<http.Response?> put(String endpoint, Map<String, dynamic> data, String idToken) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      return response;
    } catch (e) {
      print('PUT request error: $e');
      return null;
    }
  }

  /// Generalized DELETE method
  Future<http.Response?> delete(String endpoint, String idToken) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      print('DELETE request error: $e');
      return null;
    }
  }
}
