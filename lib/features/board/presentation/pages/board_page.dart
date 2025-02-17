import 'package:flutter/material.dart';
import '../widgets/board_list.dart';
import '../widgets/board_card.dart';

class BoardPage extends StatefulWidget {
  final String projectName;

  const BoardPage({
    super.key,
    required this.projectName,
  });

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  // Her liste için kartları tutacak map
  final Map<String, List<Map<String, dynamic>>> _lists = {
    'reyonlar': [
      {
        'title': 'alişan siqaret vitrini 16:00',
        'color': Colors.blue,
        'user': 'AS',
        'count': '0/145',
      },
      {
        'title': 'Dunay dasgjd',
        'color': Colors.green,
        'user': 'DK',
        'count': '23/98',
      },
      {
        'title': 'Qasim kollasa vitrini 14:55',
        'color': Colors.orange,
        'user': 'QM',
        'count': '45/76',
      },
      {
        'title': 'Anar system',
        'color': Colors.purple,
        'user': 'AS',
        'count': '12/89',
      },
      {
        'title': 'Salaman kalbasa vitrin',
        'color': Colors.red,
        'user': 'SK',
        'count': '67/120',
      },
      {
        'title': 'Alisan diger',
        'color': Colors.teal,
        'user': 'AD',
        'count': '34/167',
      },
      {
        'title': 'ferid kassa etrafi',
        'color': Colors.indigo,
        'user': 'FK',
        'count': '56/178',
      },
    ],
    'baslandi': [
      {
        'title': 'Ziyad kassa',
        'color': Colors.amber,
        'user': 'ZK',
        'count': '89/145',
      },
      {
        'title': 'Islam saqqiz vitrini. 20:15',
        'color': Colors.cyan,
        'user': 'IS',
        'count': '112/134',
      },
      {
        'title': 'alisan siqaret salina dgdgahsdgahj',
        'color': Colors.deepPurple,
        'user': 'AS',
        'count': '78/156',
      },
    ],
    'sayilir': [],
    'yoxlanilir': [],
  };

  // Kartı bir listeden diğerine taşıma
  void _moveCard(String cardTitle, String fromList, String toList) {
    setState(() {
      final cardIndex =
          _lists[fromList]?.indexWhere((card) => card['title'] == cardTitle);
      if (cardIndex != null && cardIndex != -1) {
        final card = _lists[fromList]!.removeAt(cardIndex);
        _lists[toList]?.add(card);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._lists.entries.map((entry) => _buildList(entry.key, entry.value)),
          _buildAddList(),
        ],
      ),
    );
  }

  Widget _buildList(String listTitle, List<Map<String, dynamic>> cards) {
    return DragTarget<Map<String, String>>(
      onAccept: (data) {
        if (data['fromList'] != null && data['cardTitle'] != null) {
          _moveCard(data['cardTitle']!, data['fromList']!, listTitle);
        }
      },
      builder: (context, candidateData, rejectedData) {
        return BoardList(
          title: listTitle,
          cards: cards
              .map((card) => _buildDraggableCard(
                    card['title'] as String,
                    listTitle,
                    color: card['color'] as Color,
                    userInitial: card['user'] as String,
                    countInfo: card['count'] as String,
                  ))
              .toList(),
          onAddCard: () {
            // TODO: Implement add card functionality
          },
        );
      },
    );
  }

  Widget _buildDraggableCard(
    String title,
    String listName, {
    required Color color,
    required String userInitial,
    required String countInfo,
    bool isActive = false,
  }) {
    return Draggable<Map<String, String>>(
      data: {
        'cardTitle': title,
        'fromList': listName,
      },
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: BoardCard(
            title: title,
            color: color,
            userInitial: userInitial,
            countInfo: countInfo,
            onTap: () {},
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: BoardCard(
          title: title,
          color: color,
          userInitial: userInitial,
          countInfo: countInfo,
          onTap: () {},
        ),
      ),
      child: BoardCard(
        title: title,
        color: color,
        userInitial: userInitial,
        countInfo: countInfo,
        onTap: () {
          // TODO: Implement card detail view
        },
      ),
    );
  }

  Widget _buildAddList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 280,
      height: 40,
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Implement add list functionality
          },
          borderRadius: BorderRadius.circular(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: isDark ? Colors.white70 : Colors.black54,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Liste ekle',
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
