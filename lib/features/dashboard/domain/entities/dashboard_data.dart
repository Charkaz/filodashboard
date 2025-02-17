import 'package:equatable/equatable.dart';

class DashboardData extends Equatable {
  final String title;
  final int value;
  final DateTime lastUpdated;

  const DashboardData({
    required this.title,
    required this.value,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [title, value, lastUpdated];
}
