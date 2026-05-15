import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'log_a_pint_screen.dart';

class WeeklyBreakdownScreen extends StatelessWidget {
  const WeeklyBreakdownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildComparisonGrid(),
            const SizedBox(height: 24),
            _buildChartSection(),
            const SizedBox(height: 24),
            _buildMilestones(),
            const SizedBox(height: 24),
            _buildPromoCard(),
          ],
        ),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogAPintScreen(),
                ),
              );
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
        Text('Weekly Performance', style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.onSurface)),
        const SizedBox(height: 4),
        Text("You're averaging 1.2 more pints than last week. Keep the pace!", style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildComparisonGrid() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
              border: const Border(top: BorderSide(color: Colors.white10)),
              boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 12, offset: Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AVG. PINTS/WEEK', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant, letterSpacing: 1.2)),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('8.4', style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
                    const SizedBox(width: 4),
                    Text('pts', style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
              border: const Border(top: BorderSide(color: Colors.white10)),
              boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 12, offset: Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PERSONAL BEST', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant, letterSpacing: 1.2)),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('14', style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
                    const SizedBox(width: 4),
                    Text('pts', style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChartSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: const Border(top: BorderSide(color: Colors.white10)),
        boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Consumption Flow', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)),
                child: Text('May 15 - May 21', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
              )
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar('M', 30, false),
                _buildBar('T', 60, false),
                _buildBar('W', 120, true),
                _buildBar('T', 70, false),
                _buildBar('F', 140, false, color: AppColors.primary.withValues(alpha: 0.4)),
                _buildBar('S', 90, false),
                _buildBar('S', 20, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String label, double height, bool isHighlight, {Color? color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: 32,
              height: height,
              decoration: BoxDecoration(
                color: isHighlight ? AppColors.primary.withValues(alpha: 0.8) : (color ?? Colors.white10),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                boxShadow: isHighlight ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 12)] : null,
              ),
            ),
            if (isHighlight)
              Positioned(
                top: -28,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Text('3.5', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
                ),
              )
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.labelSm.copyWith(color: isHighlight ? AppColors.primary : AppColors.onSurfaceVariant, fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }

  Widget _buildMilestones() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Milestones', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
            TextButton(onPressed: () {}, child: Text('View All', style: AppTextStyles.labelLg.copyWith(color: AppColors.primary))),
          ],
        ),
        _buildMilestoneItem(Icons.local_fire_department, '5-Day Social Streak', "You've visited the local for 5 days running.", true, AppColors.primaryContainer),
        const SizedBox(height: 12),
        _buildMilestoneItem(Icons.military_tech, 'The Connoisseur', 'Try 10 different types of draft lager.', false, AppColors.secondaryContainer, progress: 0.7),
      ],
    );
  }

  Widget _buildMilestoneItem(IconData icon, String title, String subtitle, bool completed, Color iconBg, {double? progress}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: iconBg.withValues(alpha: 0.2), shape: BoxShape.circle),
            child: Icon(icon, color: completed ? AppColors.primary : AppColors.secondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface)),
                Text(subtitle, style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
                if (progress != null) ...[
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ]
              ],
            ),
          ),
          if (completed)
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(Icons.verified, color: AppColors.primary),
            )
          else if (progress != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('7/10', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
            )
        ],
      ),
    );
  }

  Widget _buildPromoCard() {
    return Container(
      height: 192,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDFtAjya8-7xadUQmGof2dSxpu6s3fwagXJzPFw7CrVf6xDGINaJzaEmvnf3gRpPojKrvdKu8pHfY-AWBCDd1KOs43SoqhB7EbgJBgdfZN4fB2Vxiie6NWMq8pH6cc175ra7Fis8rbnvopsZPIUW0iJx5LoOT-w8-U_v_YLoyTUdnl2XeYNw7nS2GAjY-qkjgJYHpdRDrjuOxaqZlx1J1LYdFo_3I0q6orFpp7WFyXGtDK90EfGRDlB72KM35n-MRU0C3WRMpM_Hj_V'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.background,
              Colors.transparent,
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('League Legend', style: AppTextStyles.headlineLgMobile.copyWith(color: Colors.white)),
            Text('Ranked #4 in London South District', style: AppTextStyles.bodyMd.copyWith(color: Colors.white.withValues(alpha: 0.8))),
          ],
        ),
      ),
    );
  }
}
