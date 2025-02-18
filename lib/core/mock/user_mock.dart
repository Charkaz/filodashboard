class UserMock {
  static final List<Map<String, dynamic>> users = [
    {
      'id': 'user1',
      'name': 'John Doe',
      'email': 'john@example.com',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'role': 'admin',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    },
    {
      'id': 'user2',
      'name': 'Jane Smith',
      'email': 'jane@example.com',
      'avatar': 'https://i.pravatar.cc/150?img=2',
      'role': 'user',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    },
    {
      'id': 'user3',
      'name': 'Mike Johnson',
      'email': 'mike@example.com',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'role': 'user',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    },
  ];
}
