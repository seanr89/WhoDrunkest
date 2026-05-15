import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../services/database_service.dart';

class LogAPintScreen extends StatefulWidget {
  const LogAPintScreen({super.key});

  @override
  State<LogAPintScreen> createState() => _LogAPintScreenState();
}

class _LogAPintScreenState extends State<LogAPintScreen> {
  int _pintCount = 1;
  String _selectedDrink = 'Lager';

  void _increment() {
    setState(() {
      _pintCount++;
    });
  }

  void _decrement() {
    if (_pintCount > 1) {
      setState(() {
        _pintCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Outer background showing at top corners
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xff2A2A2A), // Matches the dark grey surface in the design
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHandle(),
              _buildHeader(),
              const SizedBox(height: 16),
              _buildSubtitle(),
              const SizedBox(height: 24),
              _buildCounterSection(),
              const SizedBox(height: 48),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDrinkHeader(),
                      const SizedBox(height: 16),
                      _buildDrinkGrid(),
                      const SizedBox(height: 32),
                      _buildLocationSection(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              _buildBottomAction(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 16),
        width: 48,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Quick Log',
            style: AppTextStyles.headlineLgMobile.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: AppColors.onSurfaceVariant),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return Center(
      child: Text(
        'How many pints today?',
        style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurfaceVariant),
      ),
    );
  }

  Widget _buildCounterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _decrement,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xff353535),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.remove, size: 28, color: AppColors.onSurfaceVariant),
          ),
        ),
        const SizedBox(width: 32),
        Column(
          children: [
            Text(
              _pintCount.toString().padLeft(2, '0'),
              style: AppTextStyles.displayLg.copyWith(
                color: AppColors.primaryContainer,
                fontSize: 64,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
            Text(
              'PINT${_pintCount > 1 ? 'S' : ''}',
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(width: 32),
        GestureDetector(
          onTap: _increment,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.add, size: 28, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildDrinkHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Select Drink',
          style: AppTextStyles.titleMd.copyWith(color: Colors.white, fontSize: 18),
        ),
        Text(
          'View All',
          style: AppTextStyles.labelLg.copyWith(
            color: AppColors.primaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDrinkGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.8,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        _buildDrinkCard('Lager', 'Light & Crisp', Icons.sports_bar),
        _buildDrinkCard('Stout', 'Rich & Dark', Icons.coffee_maker),
        _buildDrinkCard('IPA', 'Hoppy & Bold', Icons.grid_view),
        _buildDrinkCard('Cider', 'Sweet & Fruity', Icons.apple),
      ],
    );
  }

  Widget _buildDrinkCard(String title, String subtitle, IconData icon) {
    final isSelected = _selectedDrink == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDrink = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff332C1E) : const Color(0xff353535),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: AppColors.primaryContainer.withValues(alpha: 0.5), width: 1)
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryContainer.withValues(alpha: 0.2) : Colors.white10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isSelected ? AppColors.primaryContainer : AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleMd.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff1C1C1C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white10),
            ),
            child: const Icon(Icons.anchor, color: AppColors.primaryContainer),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current League Location',
                  style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 2),
                Text(
                  'The Rusty Anchor Pub',
                  style: AppTextStyles.titleMd.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.location_on_outlined, color: AppColors.primaryContainer),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Color(0xff353535),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: () async {
            final log = {
              'count': _pintCount,
              'drink_type': _selectedDrink,
              'location': 'The Rusty Anchor Pub', // Hardcoded for now based on UI
              'timestamp': DateTime.now().toIso8601String(),
            };
            await DatabaseService().insertLog(log);
            if (mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged $_pintCount $_selectedDrink${_pintCount > 1 ? 's' : ''}!'),
                  backgroundColor: AppColors.primary,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryContainer,
            foregroundColor: Colors.black87,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          icon: const Icon(Icons.check_circle_outline, size: 24),
          label: Text(
            'Confirm Log',
            style: AppTextStyles.titleMd.copyWith(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
