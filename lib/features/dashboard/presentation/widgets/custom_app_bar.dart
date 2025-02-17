import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme_bloc.dart';

/// Trello tipli AppBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          if (onBack != null) ...[
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack,
              tooltip: 'Geri',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 16),
          ],
          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.star_border,
            color: isDark ? Colors.white70 : Colors.black54,
            size: 20,
          ),
          const SizedBox(width: 16),
          _buildVerticalDivider(isDark),
          const SizedBox(width: 16),
          _buildMemberButton(context),
          const Spacer(),
          _buildFilterButton(context),
          const SizedBox(width: 8),
          _buildShareButton(context),
          const SizedBox(width: 8),
          _buildThemeToggle(context),
          const SizedBox(width: 8),
          _buildMoreButton(context),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider(bool isDark) {
    return Container(
      height: 16,
      width: 1,
      color: isDark ? Colors.white24 : Colors.black12,
    );
  }

  Widget _buildMemberButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark ? Colors.white24 : Colors.black12,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(
                Icons.person_outline,
                color: isDark ? Colors.white70 : Colors.black87,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Üyeler',
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color:
                      isDark ? Colors.white12 : Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark ? Colors.white24 : Colors.black12,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(
                Icons.filter_list,
                color: isDark ? Colors.white70 : Colors.black87,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Filtreler',
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark ? Colors.white24 : Colors.black12,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(
                Icons.share_outlined,
                color: isDark ? Colors.white70 : Colors.black87,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Paylaş',
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark ? Colors.white24 : Colors.black12,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                state.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: isDark ? Colors.white70 : Colors.black87,
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMoreButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark ? Colors.white24 : Colors.black12,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            Icons.more_horiz,
            color: isDark ? Colors.white70 : Colors.black87,
            size: 20,
          ),
        ),
      ),
    );
  }
}
