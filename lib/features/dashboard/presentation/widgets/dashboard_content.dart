import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/dashboard_data.dart';

class DashboardContent extends StatelessWidget {
  final DashboardData data;

  const DashboardContent({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatisticsGrid(context),
          const SizedBox(height: 24),
          _buildCharts(context),
        ],
      ),
    );
  }

  Widget _buildStatisticsGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          context,
          icon: Icons.shopping_cart,
          title: 'Ümumi Satış',
          value: '₼ 45,231',
          trend: '+12.5%',
          trendUp: true,
          color: Colors.blue,
        ),
        _buildStatCard(
          context,
          icon: Icons.people,
          title: 'Müştərilər',
          value: '1,234',
          trend: '+3.2%',
          trendUp: true,
          color: Colors.green,
        ),
        _buildStatCard(
          context,
          icon: Icons.inventory_2,
          title: 'Məhsullar',
          value: '892',
          trend: '-2.4%',
          trendUp: false,
          color: Colors.orange,
        ),
        _buildStatCard(
          context,
          icon: Icons.local_shipping,
          title: 'Sifarişlər',
          value: '156',
          trend: '+8.7%',
          trendUp: true,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String trend,
    required bool trendUp,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: trendUp
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      trendUp ? Icons.arrow_upward : Icons.arrow_downward,
                      color: trendUp ? Colors.green : Colors.red,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trend,
                      style: TextStyle(
                        color: trendUp ? Colors.green : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharts(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Satış Analizi',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'weekly',
                          child: Text('Həftəlik'),
                        ),
                        const PopupMenuItem(
                          value: 'monthly',
                          child: Text('Aylıq'),
                        ),
                        const PopupMenuItem(
                          value: 'yearly',
                          child: Text('İllik'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: 1,
                        verticalInterval: 1,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: isDark ? Colors.white10 : Colors.black12,
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: isDark ? Colors.white10 : Colors.black12,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              const style = TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              );
                              Widget text;
                              switch (value.toInt()) {
                                case 0:
                                  text = const Text('B.e', style: style);
                                  break;
                                case 2:
                                  text = const Text('Çrş', style: style);
                                  break;
                                case 4:
                                  text = const Text('Crş', style: style);
                                  break;
                                case 6:
                                  text = const Text('C.a', style: style);
                                  break;
                                default:
                                  text = const Text('');
                                  break;
                              }
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: text,
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '${value.toInt()}K',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              );
                            },
                            reservedSize: 42,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      minX: 0,
                      maxX: 7,
                      minY: 0,
                      maxY: 6,
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 3),
                            FlSpot(1, 2),
                            FlSpot(2, 4),
                            FlSpot(3, 3),
                            FlSpot(4, 5),
                            FlSpot(5, 3),
                            FlSpot(6, 4),
                          ],
                          isCurved: true,
                          color: Theme.of(context).colorScheme.primary,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(
                            show: false,
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Məhsullar',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'sales',
                          child: Text('Satışa görə'),
                        ),
                        const PopupMenuItem(
                          value: 'revenue',
                          child: Text('Gəlirə görə'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 70,
                      sections: [
                        PieChartSectionData(
                          color: Colors.blue,
                          value: 35,
                          title: '35%',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.green,
                          value: 25,
                          title: '25%',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.orange,
                          value: 20,
                          title: '20%',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.purple,
                          value: 20,
                          title: '20%',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildLegend(
                  context,
                  [
                    _LegendItem('Siqaretlər', Colors.blue, '35%'),
                    _LegendItem('İçkilər', Colors.green, '25%'),
                    _LegendItem('Qəlyanaltılar', Colors.orange, '20%'),
                    _LegendItem('Digər', Colors.purple, '20%'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(BuildContext context, List<_LegendItem> items) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item.title,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                item.value,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _LegendItem {
  final String title;
  final Color color;
  final String value;

  _LegendItem(this.title, this.color, this.value);
}
