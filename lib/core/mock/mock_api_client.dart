import 'dart:async';
import 'package:injectable/injectable.dart';
import 'board_mock.dart';
import 'project_mock.dart';
import 'user_mock.dart';

@lazySingleton
class MockApiClient {
  final _delay = const Duration(milliseconds: 800);

  Future<List<Map<String, dynamic>>> getBoards() async {
    await Future.delayed(_delay);
    return BoardMock.boards;
  }

  Future<Map<String, dynamic>> getBoardById(String id) async {
    await Future.delayed(_delay);
    return BoardMock.boards.firstWhere((board) => board['id'] == id);
  }

  Future<List<Map<String, dynamic>>> getProjects() async {
    await Future.delayed(_delay);
    return ProjectMock.projects;
  }

  Future<Map<String, dynamic>> getProjectById(String id) async {
    await Future.delayed(_delay);
    return ProjectMock.projects.firstWhere((project) => project['id'] == id);
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    await Future.delayed(_delay);
    return UserMock.users.first;
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    await Future.delayed(_delay);
    return UserMock.users;
  }

  Future<Map<String, dynamic>> getUserById(String id) async {
    await Future.delayed(_delay);
    return UserMock.users.firstWhere((user) => user['id'] == id);
  }
}
