import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'log_a_pint_screen.dart';
import '../services/storage_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildFriendsList(context),
            const SizedBox(height: 24),
            _buildSettingsList(context),
            const SizedBox(height: 24),
            _buildDataManagement(context),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Quick Log', style: AppTextStyles.labelLg),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryContainer.withValues(alpha: 0.3), width: 4),
                image: const DecorationImage(
                  image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBSRyZg57gzm3qynkBIcFNk7xZGJ91zeCXl65LsdicY24C6usW2VeuU7U82lqYCYv-9DnPtROZmvuEWgLLkFhYl_e1r7m_elvsSrMHtWCF4qN2BZM8vkQfBz3dU-JlBCg8prOn-IeoxoU21hnmgZ0I4_LXynA60kZSeRYGdwA9XESZbR92I4C5BuS1b1lye__W_-lP2P9Rp5WkyuLIMr1NKoHYhnpbgi_bNqlnTdhqDF619vUA-yiWvCgX67t5N2RsWNWHYp44EkphW'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.background, width: 2),
              ),
              child: const Icon(Icons.verified, size: 20, color: AppColors.onPrimaryFixed),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(StorageService().getUserName(), style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.bold)),
        Text('The Garrison Chapter', style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  children: [
                    Text(StorageService().getLifetimePints().toString(), style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
                    Text('LIFETIME PINTS', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant, letterSpacing: 1.2)),
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
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  children: [
                    Text(StorageService().getUserRank(), style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
                    Text('LEAGUE RANK', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant, letterSpacing: 1.2)),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildFriendsList(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('The Garrison Crew', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
            TextButton(onPressed: () {}, child: Text('Manage', style: AppTextStyles.labelLg.copyWith(color: AppColors.primary))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFriendItem('Tommy', 'https://lh3.googleusercontent.com/aida-public/AB6AXuB0D8r98l8Lo2_GuMRTkKnVsv9GSEHEVP6iZnI2O7hmkVmEB7DtlozWONoeW_7A4aCAin-moDirnAN1rmOE4j49BfBr62xhVt937VcvCkfsG5UmB2Ym7a9k6BFOom-aGa9bp65rs43xMlC7f6voipUkAH79npzPGDfGwoQiHQbM9EJzryv0rtjJR89XTRYsrAIcSbMzSzbizikKaUmhEefLAez-EQZiCMy6FdjjKoSO0KDRRv4LFrvM2OBGPbaW5qy--LBD4h-UaLD9'),
            _buildFriendItem('Polly', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAuSl0Q4n0uapRvFh0mv3lFE_V-E9Q07dpRsZSDxyGkVsm0Ie2Nv2j4d2NXtn_ecn9POBMCRTQmotQ7aN-2LDvL_74ATnmHdqgP_r4gY8fd-bKtcoLxF8zYupAMJ0XFgqx9nbQZp_rOkVKs98yO4ZkEW7j8T_oRcFPmp-RrpAq2Z4cz1xB5YATe5jdvNB_WnS_iUWCodRTtXzqvXfmUJn9aDWWpOJBlAIM1abMW6MmZolV1xcDyVooO24mFgwBaGrTTbslT_fhdN_KF'),
            _buildFriendItem('John', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDCAr07h5qVbGuBEbxWiB3QvDTL2iZsFx4syrzOyDsVavaWQ5Hpdv38kGRE9Q56H5TBhS56ANUp9OzpD3eyey-YK51QGAsl0LvX2N6Kvk6tTn9hGT5ooZo4RyfO-e7smJByRlr-hMR0lupxzICDQ2IwHeEn6BIpgBaxAk8i9QrbeVMBDWn6OFiGJc8n46UNCMUZyZ6Iu38zBvXqq3yowTKwFPB-iuTXL1-d6m5Qh0S-MDmdzoAlhF4bdwBV22A5-mFSPfpUWYfdakkY'),
            _buildInviteItem(context),
          ],
        )
      ],
    );
  }

  Widget _buildFriendItem(String name, String imgUrl) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white10),
            image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildInviteItem(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.outlineVariant, style: BorderStyle.none),
          ),
          child: Material(
            color: Colors.transparent,
            shape: CircleBorder(side: BorderSide(color: AppColors.outlineVariant, width: 2, style: BorderStyle.solid)), // Dashed not supported directly, using solid for now
            child: InkWell(
              onTap: () => _showComingSoonDialog(context, 'Invite Friends'),
              customBorder: const CircleBorder(),
              child: const Icon(Icons.add, color: AppColors.outline),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text('Invite', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
      ],
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        title: Text(
          'Coming Soon',
          style: AppTextStyles.titleMd.copyWith(color: AppColors.primary),
        ),
        content: Text(
          '$feature is not available yet. We\'re working hard to bring this to the Pint League!',
          style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Understood',
              style: AppTextStyles.labelLg.copyWith(color: AppColors.primary),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preferences', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            children: [
              _buildSettingsItem(context, Icons.account_circle, 'Account Settings', 'Email, password, and linked social', true),
              const Divider(height: 1, color: Colors.white10),
              _buildSettingsItem(context, Icons.lock, 'Privacy & Visibility', 'Who can see your stats and activity', true),
              const Divider(height: 1, color: Colors.white10),
              _buildSettingsItem(context, Icons.notifications, 'Notifications', 'League alerts and round reminders', false),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSettingsItem(BuildContext context, IconData icon, String title, String subtitle, bool showTrailing) {
    return ListTile(
      leading: Icon(icon, color: AppColors.onSurfaceVariant),
      title: Text(title, style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurface)),
      subtitle: Text(subtitle, style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
      trailing: showTrailing ? const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant) : null,
      onTap: () => _showComingSoonDialog(context, title),
    );
  }

  Widget _buildDataManagement(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Data Management', style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurface)),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.download, color: AppColors.onSurfaceVariant),
                title: Text('Export Your Data', style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurface)),
                onTap: () => _showComingSoonDialog(context, 'Data Export'),
              ),
              const Divider(height: 1, color: Colors.white10),
              ListTile(
                leading: const Icon(Icons.delete_forever, color: AppColors.error),
                title: Text('Delete Account', style: AppTextStyles.bodyLg.copyWith(color: AppColors.error)),
                onTap: () => _showComingSoonDialog(context, 'Account Deletion'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            'Pint League v2.4.0 • Built for the Ritual',
            style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant),
          ),
        )
      ],
    );
  }
}
