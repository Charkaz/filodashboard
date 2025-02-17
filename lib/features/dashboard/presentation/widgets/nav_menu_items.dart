import 'package:flutter/material.dart';

/// Yan panel menyu elementləri
class NavMenuItems extends StatelessWidget {
  final bool isExpanded;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const NavMenuItems({
    super.key,
    required this.isExpanded,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              if (isExpanded) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 16, 8),
                  child: Text(
                    'GÖRÜNÜMLER',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white54
                          : Colors.black54,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
              _buildMenuItem(
                context,
                index: 0,
                icon: Icons.table_chart_outlined,
                label: 'Tablo',
              ),
              _buildMenuItem(
                context,
                index: 1,
                icon: Icons.calendar_today_outlined,
                label: 'Takvim',
              ),
              _buildMenuItem(
                context,
                index: 2,
                icon: Icons.list_alt_outlined,
                label: 'Liste',
              ),
            ],
          ),
        ),
        _buildWorkspaceSection(context),
        _buildSettingsMenuItem(context),
      ],
    );
  }

  Widget _buildWorkspaceSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (!isExpanded) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white12 : Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                'F',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (isExpanded) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filo Dashboard',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white12
                          : Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Ücretsiz',
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettingsMenuItem(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white12 : Colors.black12,
          ),
        ),
      ),
      child: _buildMenuItem(
        context,
        index: 3,
        icon: Icons.settings_outlined,
        label: 'Ayarlar',
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    Widget? trailing,
  }) {
    final isSelected = selectedIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onItemSelected(index),
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? Colors.white10 : Colors.black.withOpacity(0.05))
                : null,
            border: isSelected
                ? Border(
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 3,
                    ),
                  )
                : null,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : (isDark ? Colors.white70 : Colors.black54),
                size: 22,
              ),
              if (isExpanded) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : (isDark ? Colors.white70 : Colors.black54),
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
