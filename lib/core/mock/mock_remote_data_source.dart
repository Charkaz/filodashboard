import 'package:injectable/injectable.dart';
import 'mock_api_client.dart';

@lazySingleton
class MockRemoteDataSource {
  final MockApiClient _apiClient;

  MockRemoteDataSource(this._apiClient);

  Future<T> mockResponse<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (e) {
      throw Exception('Mock API Error: ${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> getBoards() {
    return mockResponse(() => _apiClient.getBoards());
  }

  Future<Map<String, dynamic>> getBoardById(String id) {
    return mockResponse(() => _apiClient.getBoardById(id));
  }

  Future<List<Map<String, dynamic>>> getProjects() {
    return mockResponse(() => _apiClient.getProjects());
  }

  Future<Map<String, dynamic>> getProjectById(String id) {
    return mockResponse(() => _apiClient.getProjectById(id));
  }

  Future<Map<String, dynamic>> getCurrentUser() {
    return mockResponse(() => _apiClient.getCurrentUser());
  }

  Future<List<Map<String, dynamic>>> getUsers() {
    return mockResponse(() => _apiClient.getUsers());
  }

  Future<Map<String, dynamic>> getUserById(String id) {
    return mockResponse(() => _apiClient.getUserById(id));
  }
}
