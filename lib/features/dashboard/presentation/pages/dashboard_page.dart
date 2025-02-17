import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/collapsible_navbar.dart';
import '../widgets/nav_menu_items.dart';
import '../widgets/dashboard_content.dart';
import '../widgets/custom_app_bar.dart';
import '../../../board/presentation/pages/board_page.dart';

/// Əsas Dashboard səhifəsi
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isNavExpanded = true;
  int _selectedIndex = 0;
  String? _selectedProject;

  void _toggleNav() {
    setState(() {
      _isNavExpanded = !_isNavExpanded;
    });
  }

  void _onNavItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedProject = null; // Reset selected project when menu item changes
    });
  }

  void _onProjectSelected(String projectName) {
    setState(() {
      _selectedProject = projectName;
    });
  }

  String _getTitle() {
    if (_selectedProject != null) {
      return _selectedProject!;
    }
    switch (_selectedIndex) {
      case 0:
        return 'Tablo';
      case 1:
        return 'Takvim';
      case 2:
        return 'Liste';
      case 3:
        return 'Ayarlar';
      default:
        return 'Tablo';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Row(
        children: [
          CollapsibleNavbar(
            isExpanded: _isNavExpanded,
            onToggle: _toggleNav,
            onProjectSelected: _onProjectSelected,
            child: NavMenuItems(
              isExpanded: _isNavExpanded,
              selectedIndex: _selectedIndex,
              onItemSelected: _onNavItemSelected,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                CustomAppBar(
                  title: _getTitle(),
                  onBack: _selectedProject != null
                      ? () {
                          setState(() {
                            _selectedProject = null;
                          });
                        }
                      : null,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _selectedProject != null
                          ? BoardPage(projectName: _selectedProject!)
                          : _buildContent(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DashboardLoaded) {
              return DashboardContent(data: state.data);
            } else if (state is DashboardError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () {
                        context
                            .read<DashboardBloc>()
                            .add(GetDashboardDataEvent());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Yenilə'),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.table_chart_outlined,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tablo Görünümü',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Məlumatları yükləmək üçün aşağıdakı düyməni basın',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {
                      context
                          .read<DashboardBloc>()
                          .add(GetDashboardDataEvent());
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Məlumatları yüklə'),
                  ),
                ],
              ),
            );
          },
        );
      case 1:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              const Text(
                'Takvim Görünümü',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bu bölmə hazırlanır...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      case 2:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.list_alt_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              const Text(
                'Liste Görünümü',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bu bölmə hazırlanır...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      case 3:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.settings_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              const Text(
                'Ayarlar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bu bölmə hazırlanır...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      default:
        return const Center(
          child: Text(
            'Səhifə tapılmadı',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
    }
  }
}
