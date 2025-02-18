import 'package:flutter/material.dart';
import 'board_card.dart';

class DraggableBoardCard extends StatelessWidget {
  final String title;
  final String listName;
  final String boardId;
  final Color color;
  final String userInitial;
  final String countInfo;
  final bool isActive;

  const DraggableBoardCard({
    super.key,
    required this.title,
    required this.listName,
    required this.boardId,
    required this.color,
    required this.userInitial,
    required this.countInfo,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Draggable<Map<String, dynamic>>(
          data: {
            'boardId': boardId,
            'fromList': listName,
          },
          feedback: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 250,
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
            opacity: 0.2,
            child: BoardCard(
              title: title,
              color: color.withOpacity(0.3),
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
      },
    );
  }
}
