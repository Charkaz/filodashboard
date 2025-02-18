class BoardMock {
  static final List<Map<String, dynamic>> boards = [
    {
      'id': '1',
      'title': 'To Do',
      'description': 'Tasks that need to be done',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'cards': [
        {
          'id': '1',
          'title': 'Implement login',
          'description': 'Create login screen and functionality',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'status': 'todo',
          'assignee_id': 'user1',
        },
        {
          'id': '2',
          'title': 'Design dashboard',
          'description': 'Create dashboard UI design',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'status': 'todo',
          'assignee_id': 'user2',
        },
      ],
    },
    {
      'id': '2',
      'title': 'In Progress',
      'description': 'Tasks currently being worked on',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'cards': [],
    },
    {
      'id': '3',
      'title': 'Done',
      'description': 'Completed tasks',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'cards': [],
    },
  ];
}
