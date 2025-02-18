import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/board_bloc.dart';
import 'board_list.dart';
import 'draggable_board_card.dart';

class BoardListItem extends StatelessWidget {
  final String listTitle;
  final List<Map<String, dynamic>> cards;

  const BoardListItem({
    super.key,
    required this.listTitle,
    required this.cards,
  });

  String _getStatusFromListTitle(BuildContext context, String listTitle) {
    final columns = context.read<BoardBloc>().state.columns;
    final column = columns.firstWhere(
      (col) => col['title'] == listTitle,
      orElse: () => columns.first,
    );
    return column['id'];
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Map<String, dynamic>>(
      onAccept: (data) {
        final fromList = data['fromList'];
        final boardId = data['boardId'];

        if (fromList != null && boardId != null && fromList != listTitle) {
          context.read<BoardBloc>().add(MoveBoard(
                boardId: boardId,
                newStatus: _getStatusFromListTitle(context, listTitle),
              ));
        }
      },
      onWillAccept: (data) {
        return data?['fromList'] != listTitle;
      },
      onMove: (details) {},
      builder: (context, candidateData, rejectedData) {
        return Container(
          decoration: BoxDecoration(
            color: candidateData.isNotEmpty
                ? Theme.of(context).highlightColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: BoardList(
            title: listTitle,
            cards: cards
                .map((card) => DraggableBoardCard(
                      title: card['title'] as String,
                      listName: listTitle,
                      boardId: card['id'] as String,
                      color: Theme.of(context).primaryColor,
                      userInitial: (card['assignee_id'] as String?)
                              ?.substring(0, 2)
                              .toUpperCase() ??
                          'NA',
                      countInfo: '${(card['cards'] as List?)?.length ?? 0}/100',
                    ))
                .toList(),
            onAddCard: () {},
          ),
        );
      },
    );
  }
}
