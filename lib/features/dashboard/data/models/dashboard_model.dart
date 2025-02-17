import '../../domain/entities/dashboard_data.dart';

class DashboardModel extends DashboardData {
  const DashboardModel({
    required String title,
    required int value,
    required DateTime lastUpdated,
  }) : super(
          title: title,
          value: value,
          lastUpdated: lastUpdated,
        );

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      title: json['title'] as String,
      value: json['value'] as int,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
