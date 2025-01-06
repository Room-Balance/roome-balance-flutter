import 'package:flutter/material.dart';
import 'package:home_balance_flutter/services/api_service.dart';
import 'package:home_balance_flutter/models/models.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  List<Task> _tasks = [];
  List<User> _users = [];
  Map<String, dynamic>? _houseData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final cachedData = await _apiService.getCachedUserData();
    if (cachedData != null) {
      setState(() {
        _tasks = (cachedData['tasks'] as List)
            .map((taskJson) => Task.fromJson(taskJson))
            .toList();
        _users = (cachedData['users'] as List)
            .map((userJson) => User.fromJson(userJson))
            .toList();
        _houseData = cachedData['house'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _houseData == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Text('House: ${_houseData?['name']}'),
                Text('Rent: \$${_houseData?['rent']}'),
                Expanded(
                  child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return ListTile(
                        title: Text(task.taskName),
                        subtitle: Text('Assigned to: ${task.assignedUser}'),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
