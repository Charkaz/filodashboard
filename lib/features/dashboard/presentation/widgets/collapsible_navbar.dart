import 'package:flutter/material.dart';

/// Profesyonel yan menü
class CollapsibleNavbar extends StatefulWidget {
  final Widget child;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Function(String) onProjectSelected;

  const CollapsibleNavbar({
    super.key,
    required this.child,
    required this.isExpanded,
    required this.onToggle,
    required this.onProjectSelected,
  });

  @override
  State<CollapsibleNavbar> createState() => _CollapsibleNavbarState();
}

class _CollapsibleNavbarState extends State<CollapsibleNavbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  final double _expandedWidth = 280;
  final double _collapsedWidth = 64;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _widthAnimation = Tween<double>(
      begin: _collapsedWidth,
      end: _expandedWidth,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isExpanded) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(CollapsibleNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: _widthAnimation.value,
            height: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: widget.isExpanded
                ? _buildExpandedContent(context)
                : _buildCollapsedContent(context),
          );
        },
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildWorkspaceSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkspaceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionDivider('ÇALIŞMA ALANI'),
        _buildMenuItem(
          icon: Icons.dashboard_outlined,
          label: 'Dashboard',
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.people_outline,
          label: 'Üyeler',
          trailing: _buildAddButton(),
          onTap: () {},
        ),
        _buildProjectsSection(),
      ],
    );
  }

  Widget _buildProjectsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMenuItem(
          icon: Icons.inventory_2_outlined,
          label: 'Sayım Projeleri',
          trailing:
              _buildAddButton(onTap: () => _showCreateProjectDialog(context)),
          onTap: () {},
        ),
        // Sayım Projeleri
        Padding(
          padding: const EdgeInsets.only(left: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProjectItem('Anbar 1', color: Colors.blue, isActive: true),
              _buildProjectItem('Anbar 2', color: Colors.green),
              _buildProjectItem('Anbar 3', color: Colors.orange),
              _buildProjectItem('Anbar 4', color: Colors.purple),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectItem(String title,
      {bool isActive = false, required Color color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onProjectSelected(title),
        borderRadius: BorderRadius.circular(4),
        hoverColor: isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.05),
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? color : color.withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isActive
                        ? color
                        : (isDark ? Colors.white70 : Colors.black87),
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 16,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateProjectDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Yeni Sayım Projesi',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Anbar Adı',
                hintText: 'Örn: Anbar 1',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.warehouse_outlined),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  widget.onProjectSelected(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'İptal',
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
          FilledButton.icon(
            onPressed: () {
              final projectName = controller.text.trim();
              if (projectName.isNotEmpty) {
                widget.onProjectSelected(projectName);
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('Oluştur'),
          ),
        ],
      ),
    );
  }

  Widget _buildMainMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionDivider('GÖRÜNÜMLER'),
        _buildMenuItem(
          icon: Icons.table_chart_outlined,
          label: 'Tablo',
          isActive: true,
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.calendar_today_outlined,
          label: 'Takvim',
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.list_alt_outlined,
          label: 'Liste',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildViewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionDivider('ÖZEL GÖRÜNÜMLER'),
        _buildMenuItem(
          icon: Icons.star_outline,
          label: 'Yıldızlı',
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.access_time,
          label: 'Son Görüntülenen',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildBoardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PANOLAR',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              _buildAddButton(),
            ],
          ),
        ),
        _buildMenuItem(
          icon: Icons.dashboard_outlined,
          label: 'Genel Bakış',
          isActive: true,
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.dashboard_outlined,
          label: 'Projeler',
          badge: '3',
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.keyboard_arrow_down,
          label: 'Daha Fazla Göster',
          badge: '5',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          _buildLogo(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filo Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Ücretsiz',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.white),
            onPressed: widget.onToggle,
            tooltip: 'Daralt',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
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
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    return InkWell(
      onTap: widget.onToggle,
      child: Column(
        children: [
          _buildCollapsedHeader(context),
          const Divider(height: 1, color: Colors.white24),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildCollapsedMenuItem(Icons.dashboard_outlined,
                    isActive: true),
                _buildCollapsedMenuItem(Icons.people_outline),
                _buildCollapsedMenuItem(Icons.settings_outlined),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(height: 1, color: Colors.white24),
                ),
                _buildCollapsedMenuItem(Icons.table_chart_outlined),
                _buildCollapsedMenuItem(Icons.calendar_today_outlined),
                _buildCollapsedMenuItem(Icons.list_alt_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsedHeader(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogo(),
        ],
      ),
    );
  }

  Widget _buildCollapsedMenuItem(IconData icon, {bool isActive = false}) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
        border: isActive
            ? Border(
                left: BorderSide(
                  color: Colors.white.withOpacity(0.9),
                  width: 3,
                ),
              )
            : null,
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.white : Colors.white70,
        size: 20,
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    Widget? trailing,
    String? badge,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        hoverColor: isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.05),
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isActive
                ? (isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05))
                : Colors.transparent,
            border: isActive
                ? Border(
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 3,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : (isDark ? Colors.white70 : Colors.black87),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isActive
                        ? Theme.of(context).colorScheme.primary
                        : (isDark ? Colors.white70 : Colors.black87),
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
              if (badge != null) _buildBadge(badge),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isDark ? Colors.white70 : Colors.black87,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAddButton({VoidCallback? onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            Icons.add,
            color: isDark ? Colors.white70 : Colors.black87,
            size: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionDivider(String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white54 : Colors.black54,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
