class ProjectMock {
  static final List<Map<String, dynamic>> projects = [
    {
      'id': '1',
      'name': 'E-Commerce App',
      'description': 'Online shopping platform development',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'status': 'active',
      'owner_id': 'user1',
    },
    {
      'id': '2',
      'name': 'CRM System',
      'description': 'Customer relationship management system',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'status': 'active',
      'owner_id': 'user1',
    },
    {
      'id': '3',
      'name': 'Mobile Banking',
      'description': 'Mobile banking application',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'status': 'pending',
      'owner_id': 'user2',
    },
  ];
}
