import 'package:equatable/equatable.dart';

class BoardEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<CardEntity> cards;

  const BoardEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    this.cards = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        createdAt,
        updatedAt,
        cards,
      ];
}

class CardEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String status;
  final int order;

  const CardEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    required this.status,
    required this.order,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        createdAt,
        updatedAt,
        status,
        order,
      ];
}
