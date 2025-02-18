import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/mock/mock_remote_data_source.dart';
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
  late MockRemoteDataSource _mockDataSource;
  Map<String, List<Map<String, dynamic>>> _lists = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _mockDataSource = context.read<MockRemoteDataSource>();
    _loadBoards();
  }

  Future<void> _loadBoards() async {
    try {
      final boards = await _mockDataSource.getBoards();
      print('Loaded boards: $boards'); // Debug print

      setState(() {
        _lists = {
          'reyonlar':
              boards.where((board) => board['status'] == 'todo').map((board) {
            final firstCard = (board['cards'] as List).firstOrNull;
            print('Todo board: ${board['title']}'); // Debug print
            return {
              'title': board['title'],
              'color': _getRandomColor(),
              'user':
                  firstCard?['assignee_id']?.substring(0, 2).toUpperCase() ??
                      'NA',
              'count': '${(board['cards'] as List).length}/100',
            };
          }).toList(),
          'baslandi': boards
              .where((board) => board['status'] == 'in_progress')
              .map((board) {
            final firstCard = (board['cards'] as List).firstOrNull;
            print('In progress board: ${board['title']}'); // Debug print
            return {
              'title': board['title'],
              'color': _getRandomColor(),
              'user':
                  firstCard?['assignee_id']?.substring(0, 2).toUpperCase() ??
                      'NA',
              'count': '${(board['cards'] as List).length}/100',
            };
          }).toList(),
          'sayilir': [],
          'yoxlanilir': [],
        };
        print('Final lists: $_lists'); // Debug print
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading boards: $e'); // Debug print
      setState(() => _isLoading = false);
    }
  }

  Color _getRandomColor() {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
      Colors.deepPurple,
    ];
    return colors[DateTime.now().millisecond % colors.length];
  }

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
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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
