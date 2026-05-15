import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'log_a_pint_screen.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

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
                  Text('#4', style: AppTextStyles.displayLg.copyWith(color: AppColors.primary)),
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
              Text('14 Pints This Week', style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurface)),
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildLeaderboardItem(1, 'James Miller', 'The Brewmaster', '22', '2', Icons.trending_up, AppColors.primary, 'https://lh3.googleusercontent.com/aida-public/AB6AXuAxYm1Io9E4egxe-bLNXG3NBCrTIftnum8eb8EKIpw-bMOzS1AVs8WsbaA3lBRMuSlIR7ELUHDvM2eW6SbXVTyUkmu67VEz62rg-ghXb4XHpSjfRmAYP0znD4EoWDEnBATLZNBn_ESVSEm7L9EQsGs8FCIdK8JL02HzbJCZZBe0HSMN2aEyxnmitrzge299IfNs5gvPPcTZ29YU1sv1OvgsypkeaUe2yh5iJhn_9TrMI_t9_zqDJXeAZv1-SoMi_axvddGud0wSpeF_'),
          _buildLeaderboardItem(2, 'Sarah Chen', 'Craft Enthusiast', '19', '0', Icons.trending_flat, AppColors.secondary, 'https://lh3.googleusercontent.com/aida-public/AB6AXuCMQ42nGwZaeHgf-eZfpkRBWVmUPk0CtNIFbgSc3kdjqGluB6UE1DvpVTgGYhgGZtk10443xu6jJ3arH9oHRBo_q5xIKIZqBcSIgIwcM8xsHUoqGepDz6jdO7om7C9bFpWflIuD9TUbXaotij2qlZbxdIpypS7HwwYUDKr2VwRpebL09kc7yNnxA5GpwjZT1nISjNZpNEYtpK9RJc3Q9RumpOIba-X860F5TdLsioS-pc9qV7Gf16H-CXa6v45J2W8wnlemqNHFRZCa'),
          _buildLeaderboardItem(3, 'Marcus Thorne', 'Social Legend', '17', '1', Icons.trending_down, AppColors.tertiary, 'https://lh3.googleusercontent.com/aida-public/AB6AXuDR0j_pnjFNZPg8iXGBVChyqgxbNR0Gyy-dAzwCtTy2-XgvKt4LVoYbL--k410WcxXW2xqjG0VZKMPLQcni3r3FwjOiJihmjY_tvney3y7Zd-46FtBpSWu9J_VSL-rP5ge7buEejMLWZtzstmkKSH8sGwVyohogQ4u-UyzSC95XtFlcTXB7ILkcrjgIcb79vF5aKslQum3Ybs9QOgDcu0kJkxdsqOXlN4tziciCBhVzz97x3MoDa6KacYrXXo_4iIw0fHcVmjexvOGU', trendColor: AppColors.error),
          _buildUserItem(),
          _buildLeaderboardItem(5, "Liam O'Neill", 'Stout Specialist', '12', '0', Icons.trending_flat, Colors.white10, 'https://lh3.googleusercontent.com/aida-public/AB6AXuAQ32xFG_BkqxYFdMPcgwMgYQcv7RPgC7njhjU-EUnGP4KdGSfW2OWhk_eggNwPTTpvos6UXtraaK2zCmKjrYEmcWy6LBUwqXWdo_cnHkkCbdZxfZylz4zEMJSHCl8w3m17CYbom97Rj5Ii-qW3KoY9hJRFkJrWdrNu37N3WMIlyvw46t9eXuNao3JIhsY62rzUQBD-iczMnOHEgY9s0BHBnzsJWUQVNBK_SjE0cgPEyTiPcDPPy6pgKT3WJjO04JPg3KIcF0l4NBto', badgeColor: AppColors.surfaceContainerHighest, badgeTextColor: AppColors.onSurface, isLast: true),
        ],
      ),
    );
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

  Widget _buildUserItem() {
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
                  child: const Text('4', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.bold)),
                Text('Pro Status', style: AppTextStyles.labelSm.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('14', style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
              Row(
                children: [
                  const Icon(Icons.trending_up, size: 12, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text('3', style: AppTextStyles.labelSm.copyWith(color: AppColors.primary)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
