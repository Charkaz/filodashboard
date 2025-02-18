import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/mock/mock_remote_data_source.dart';
import 'package:flutter/material.dart';

// Events
abstract class BoardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBoards extends BoardEvent {}

class AddBoard extends BoardEvent {
  final String title;
  final String description;

  AddBoard({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}

class MoveBoard extends BoardEvent {
  final String boardId;
  final String newStatus;

  MoveBoard({
    required this.boardId,
    required this.newStatus,
  });

  @override
  List<Object?> get props => [boardId, newStatus];
}

// State
class BoardState extends Equatable {
  final List<Map<String, dynamic>> boards;
  final bool isLoading;
  final String? error;

  const BoardState({
    this.boards = const [],
    this.isLoading = true,
    this.error,
  });

  BoardState copyWith({
    List<Map<String, dynamic>>? boards,
    bool? isLoading,
    String? error,
  }) {
    return BoardState(
      boards: boards ?? this.boards,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  Map<String, List<Map<String, dynamic>>> get groupedBoards {
    return {
      'reyonlar': boards.where((board) => board['status'] == 'todo').toList(),
      'baslandi':
          boards.where((board) => board['status'] == 'in_progress').toList(),
      'sayilir':
          boards.where((board) => board['status'] == 'counting').toList(),
      'yoxlanilir':
          boards.where((board) => board['status'] == 'review').toList(),
    };
  }

  @override
  List<Object?> get props => [boards, isLoading, error];
}

// Bloc
class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final MockRemoteDataSource _mockDataSource;

  BoardBloc(this._mockDataSource) : super(const BoardState()) {
    on<LoadBoards>(_onLoadBoards);
    on<AddBoard>(_onAddBoard);
    on<MoveBoard>(_onMoveBoard);
  }

  Future<void> _onLoadBoards(LoadBoards event, Emitter<BoardState> emit) async {
    try {
      final boards = await _mockDataSource.getBoards();
      emit(state.copyWith(boards: boards, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _onAddBoard(AddBoard event, Emitter<BoardState> emit) async {
    try {
      final newBoard = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': event.title,
        'description': event.description,
        'status': 'todo',
        'cards': [],
        'created_at': DateTime.now().toIso8601String(),
      };

      final updatedBoards = [...state.boards, newBoard];
      emit(state.copyWith(boards: updatedBoards));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onMoveBoard(MoveBoard event, Emitter<BoardState> emit) async {
    try {
      final updatedBoards = state.boards.map((board) {
        if (board['id'] == event.boardId) {
          return {...board, 'status': event.newStatus};
        }
        return board;
      }).toList();

      emit(state.copyWith(boards: updatedBoards));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
