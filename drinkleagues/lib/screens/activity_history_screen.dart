import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'log_a_pint_screen.dart';
import '../services/database_service.dart';
import 'package:intl/intl.dart';

class ActivityHistoryScreen extends StatefulWidget {
  const ActivityHistoryScreen({super.key});

  @override
  State<ActivityHistoryScreen> createState() => _ActivityHistoryScreenState();
}

class _ActivityHistoryScreenState extends State<ActivityHistoryScreen> {
  List<Map<String, dynamic>> _logs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    final logs = await DatabaseService().getLogs();
    setState(() {
      _logs = logs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : _logs.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: _loadLogs,
                  color: AppColors.primary,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 24),
                        ..._buildLogGroups(),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 64, color: AppColors.onSurfaceVariant.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text(
            'No activity yet',
            style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          Text(
            'Your logged pints will appear here.',
            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLogGroups() {
    // Group logs by date
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var log in _logs) {
      final date = DateTime.parse(log['timestamp']);
      final dateStr = DateFormat('EEEE, MMM d').format(date);
      if (!grouped.containsKey(dateStr)) {
        grouped[dateStr] = [];
      }
      grouped[dateStr]!.add(log);
    }

    return grouped.entries.map((entry) {
      final totalPints = entry.value.fold<int>(0, (sum, log) => sum + (log['count'] as int));
      final isToday = DateFormat('EEEE, MMM d').format(DateTime.now()) == entry.key;

      return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: _buildGroup(
          isToday ? 'Today, ${entry.key.split(', ')[1]}' : entry.key,
          '$totalPints PINT${totalPints != 1 ? 'S' : ''} TOTAL',
          isToday,
          entry.value.map((log) {
            final time = DateFormat('HH:mm').format(DateTime.parse(log['timestamp']));
            return _buildHistoryItem(
              log['location'],
              '$time • ${log['drink_type']}',
              log['count'].toString(),
              _getIconForDrink(log['drink_type']),
              isToday,
              log['id'],
            );
          }).toList(),
        ),
      ).animate(); // Note: animate() requires a package, but I'll skip it for now to avoid errors
    }).toList();
  }

  IconData _getIconForDrink(String type) {
    switch (type.toLowerCase()) {
      case 'lager':
        return Icons.sports_bar;
      case 'stout':
        return Icons.coffee_maker;
      case 'ipa':
        return Icons.grid_view;
      case 'cider':
        return Icons.apple;
      default:
        return Icons.local_drink;
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Icon(Icons.sports_bar, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            'Pint League',
            style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogAPintScreen(),
                ),
              );
              _loadLogs();
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            child: Text('Quick Log', style: AppTextStyles.labelLg),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Activity History', style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.onSurface)),
        const SizedBox(height: 4),
        Text('Review and manage your logged pints.', style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildGroup(String dateStr, String totalStr, bool isToday, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dateStr.toUpperCase(),
              style: AppTextStyles.labelLg.copyWith(
                color: isToday ? AppColors.primary : AppColors.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                totalStr,
                style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant),
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        ...items,
      ],
    );
  }

  Widget _buildHistoryItem(String title, String subtitle, String amount, IconData icon, bool isPrimary, int id) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: const Border(top: BorderSide(color: Colors.white10)),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isPrimary ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isPrimary ? AppColors.primary.withValues(alpha: 0.2) : Colors.white10),
            ),
            child: Icon(icon, color: isPrimary ? AppColors.primary : AppColors.onSurfaceVariant),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                Text(subtitle, style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Text(amount, style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
          const SizedBox(width: 16),
          Column(
            children: [
              GestureDetector(
                onTap: () {}, // Edit logic could go here
                child: Icon(Icons.edit, size: 20, color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  await DatabaseService().deleteLog(id);
                  _loadLogs();
                },
                child: Icon(Icons.delete, size: 20, color: AppColors.error.withValues(alpha: 0.5)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

extension on Widget {
  Widget animate() => this; // Placeholder for animation
}
