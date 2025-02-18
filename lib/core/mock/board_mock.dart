class BoardMock {
  static final List<Map<String, dynamic>> boards = [
    {
      'id': '1',
      'title': 'Alişan siqaret vitrini 16:00',
      'description': 'Vitrin sayımı',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'status': 'todo',
      'cards': [
        {
          'id': '1',
          'title': 'Siqaret A',
          'description': 'Siqaret sayımı',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'status': 'todo',
          'assignee_id': 'AS',
        },
      ],
    },
    {
      'id': '2',
      'title': 'Qasim kollasa vitrini 14:55',
      'description': 'Kollasa sayımı',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'status': 'todo',
      'cards': [
        {
          'id': '2',
          'title': 'Kollasa B',
          'description': 'Kollasa sayımı',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'status': 'todo',
          'assignee_id': 'QM',
        },
      ],
    },
    {
      'id': '3',
      'title': 'Ziyad kassa',
      'description': 'Kassa sayımı',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'status': 'in_progress',
      'cards': [
        {
          'id': '3',
          'title': 'Kassa C',
          'description': 'Kassa sayımı',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'status': 'in_progress',
          'assignee_id': 'ZK',
        },
      ],
    },
    {
      'id': '4',
      'title': 'Islam saqqiz vitrini 20:15',
      'description': 'Saqqiz sayımı',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'status': 'in_progress',
      'cards': [
        {
          'id': '4',
          'title': 'Saqqiz D',
          'description': 'Saqqiz sayımı',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'status': 'in_progress',
          'assignee_id': 'IS',
        },
      ],
    },
  ];

  static final Map<String, dynamic> boardConfig = {
    'columns': [
      {
        'id': 'todo',
        'title': 'reyonlar',
        'order': 1,
      },
      {
        'id': 'in_progress',
        'title': 'baslandi',
        'order': 2,
      },
      {
        'id': 'counting',
        'title': 'sayilir',
        'order': 3,
      },
      {
        'id': 'review',
        'title': 'yoxlanilir',
        'order': 4,
      },
    ],
  };
}
