import 'api_client.dart';
import 'dart:convert';

class TaskService {
  final ApiClient _apiClient = ApiClient();


  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final response = await _apiClient.get('tasks');
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch tasks: ${response.body}');
    }
  }

  // GET
  Future<Map<String, dynamic>> fetchTask(String taskId) async {
    final response = await _apiClient.get('tasks/$taskId');
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch task: ${response.body}');
    }
  }

  // POST
  Future<void> addTask(String description, String type, String status, DateTime dueDate) async {
    final response = await _apiClient.post('tasks', {
      'description': description,
      'type': type,
      'status': status,
      'dueDate': dueDate.toIso8601String(),
    });
    if (response.statusCode != 201) {
      throw Exception('Failed to create task: ${response.body}');
    }
  }

  // PUT
  Future<void> updateTask(String taskId, String description, String type, String status, DateTime dueDate) async {
    final response = await _apiClient.put('tasks/$taskId', {
      'description': description,
      'type': type,
      'status': status,
      'dueDate': dueDate.toIso8601String(),
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to update task: ${response.body}');
    }
  }

  // DELETE 
  Future<void> deleteTask(String taskId) async {
    final response = await _apiClient.delete('tasks/$taskId');
    if (response.statusCode != 204) {
      throw Exception('Failed to delete task: ${response.body}');
    }
  }
}
