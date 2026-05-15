import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'log_a_pint_screen.dart';
import '../services/database_service.dart';
import '../services/storage_service.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Map<String, dynamic>> _performers = [];
  int _userWeeklyPints = 0;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      final performers = await DatabaseService().getPerformers();
      final weeklyPints = await DatabaseService().getUserWeeklyPints();
      setState(() {
        _performers = performers;
        _userWeeklyPints = weeklyPints;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load leaderboard data';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : _errorMessage != null
              ? _buildErrorState()
              : RefreshIndicator(
                  onRefresh: _loadData,
              color: AppColors.primary,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildToggleView(),
                    const SizedBox(height: 24),
                    _buildSummaryCard(),
                    const SizedBox(height: 24),
                    _buildLeaderboardHeader(),
                    const SizedBox(height: 12),
                    _buildLeaderboardList(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 16),
          Text(_errorMessage!, style: AppTextStyles.bodyLg.copyWith(color: Colors.white)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadData,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.black,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
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
              _loadData();
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

  Widget _buildToggleView() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(child: _buildToggleBtn('Weekly', true)),
          Expanded(child: _buildToggleBtn('Monthly', false)),
          Expanded(child: _buildToggleBtn('Yearly', false)),
        ],
      ),
    );
  }

  Widget _buildToggleBtn(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: AppTextStyles.labelLg.copyWith(
          color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    // Calculate rank
    int rank = 1;
    for (var p in _performers) {
      if (p['score'] > _userWeeklyPints) {
        rank++;
      }
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: const Border(top: BorderSide(color: Colors.white10)),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('YOUR CURRENT RANK', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
                  Text('#$rank', style: AppTextStyles.displayLg.copyWith(color: AppColors.primary)),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.military_tech, color: AppColors.primaryFixedDim, size: 32),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text('$_userWeeklyPints Pints This Week', style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurface)),
              const SizedBox(width: 8),
              Row(
                children: [
                  const Icon(Icons.trending_up, color: AppColors.primary, size: 16),
                  const SizedBox(width: 4),
                  Text('+12%', style: AppTextStyles.labelSm.copyWith(color: AppColors.primary)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLeaderboardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Top Performers', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
        const Icon(Icons.filter_list, color: AppColors.onSurfaceVariant),
      ],
    );
  }

  Widget _buildLeaderboardList() {
    // Merge user into performers and sort
    final List<Map<String, dynamic>> combined = List.from(_performers);
    combined.add({
      'name': 'You',
      'status': 'Pro Status',
      'score': _userWeeklyPints,
      'trend': 'up',
      'trend_score': '3',
      'img_url': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBMIQK8KWbKM8Y0P4pmiJ9YkgobpLrKdUvjudHt57P6Vn3rHimnrzCBWtT8vwkHy7EwiEIixBERM5wRTSeWyQFXKAM1UBbChUKl7CwcVed6YwgbMBOVqkWuk9Lq_KgH2DNWw9rARbrGRqljQjJ2McNyDBI8nVEqkH8lwjcsfTaH7dimt1nYFBUwJq9g0tdY4G3_qwYBhA9zplLsGpYF3sdQzCjNVq_71wj1VekPO-8wooLg_I6OCRqKPqeeyKbszTCXjMCxAMGdi5mH',
      'is_user': 1,
    });
    
    combined.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: combined.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == combined.length - 1;
          
          if (item['is_user'] == 1) {
            return _buildUserItem(item['score'].toString(), index + 1);
          } else {
            return _buildLeaderboardItem(
              index + 1,
              item['name'],
              item['status'],
              item['score'].toString(),
              item['trend_score'],
              _getTrendIcon(item['trend']),
              _getBorderColor(index + 1),
              item['img_url'],
              trendColor: item['trend'] == 'down' ? AppColors.error : null,
              isLast: isLast,
            );
          }
        }).toList(),
      ),
    );
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case 'up':
        return Icons.trending_up;
      case 'down':
        return Icons.trending_down;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getBorderColor(int rank) {
    switch (rank) {
      case 1:
        return AppColors.primary;
      case 2:
        return AppColors.secondary;
      case 3:
        return AppColors.tertiary;
      default:
        return Colors.white10;
    }
  }

  Widget _buildLeaderboardItem(int rank, String name, String subtitle, String score, String trendScore, IconData trendIcon, Color avatarBorder, String imgUrl, {Color? trendColor, Color? badgeColor, Color? badgeTextColor, bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: isLast ? null : const Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: avatarBorder, width: 2),
                  image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: -4,
                right: -4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: badgeColor ?? avatarBorder,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    rank.toString(),
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: badgeTextColor ?? Colors.black),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
                Text(subtitle, style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(score, style: AppTextStyles.headlineLgMobile.copyWith(color: rank == 1 ? AppColors.primary : AppColors.onSurface)),
              Row(
                children: [
                  Icon(trendIcon, size: 12, color: trendColor ?? (rank == 1 ? AppColors.primary : AppColors.onSurfaceVariant)),
                  const SizedBox(width: 4),
                  Text(trendScore, style: AppTextStyles.labelSm.copyWith(color: trendColor ?? (rank == 1 ? AppColors.primary : AppColors.onSurfaceVariant))),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildUserItem(String score, int rank) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer.withValues(alpha: 0.1),
        border: const Border(
          left: BorderSide(color: AppColors.primary, width: 4),
          bottom: BorderSide(color: Colors.white10),
        ),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                  image: const DecorationImage(image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBMIQK8KWbKM8Y0P4pmiJ9YkgobpLrKdUvjudHt57P6Vn3rHimnrzCBWtT8vwkHy7EwiEIixBERM5wRTSeWyQFXKAM1UBbChUKl7CwcVed6YwgbMBOVqkWuk9Lq_KgH2DNWw9rARbrGRqljQjJ2McNyDBI8nVEqkH8lwjcsfTaH7dimt1nYFBUwJq9g0tdY4G3_qwYBhA9zplLsGpYF3sdQzCjNVq_71wj1VekPO-8wooLg_I6OCRqKPqeeyKbszTCXjMCxAMGdi5mH'), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: -4,
                right: -4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(rank.toString(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StorageService().getUserName(), style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.bold)),
                Text('Pro Status', style: AppTextStyles.labelSm.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(score, style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
              Row(
                children: [
                  const Icon(Icons.trending_up, size: 12, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text('3', style: AppTextStyles.labelSm),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
