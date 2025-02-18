import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final List<String> roles;
  final bool isActive;

  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    this.avatarUrl,
    required this.createdAt,
    this.lastLoginAt,
    this.roles = const [],
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        avatarUrl,
        createdAt,
        lastLoginAt,
        roles,
        isActive,
      ];
}
