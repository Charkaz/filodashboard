import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/board_bloc.dart';
import '../widgets/board_list_item.dart';
import '../widgets/add_list_button.dart';

class BoardPage extends StatelessWidget {
  final String projectName;

  const BoardPage({
    super.key,
    required this.projectName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoardBloc(context.read())..add(LoadBoards()),
      child: const _BoardPageView(),
    );
  }
}

class _BoardPageView extends StatelessWidget {
  const _BoardPageView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardBloc, BoardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...state.groupedBoards.entries.map(
                (entry) => BoardListItem(
                  listTitle: entry.key,
                  cards: entry.value,
                ),
              ),
              const AddListButton(),
            ],
          ),
        );
      },
    );
  }
}
