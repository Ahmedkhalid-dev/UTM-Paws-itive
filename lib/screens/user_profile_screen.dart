import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/status_chip.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  _ProfileTab _selectedTab = _ProfileTab.reports;

  static const _avatarUrl =
      'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e'
      '?w=200&h=200&fit=crop&crop=face';

  static const _reports = [
    _ProfileReport(
      name: 'Milo',
      type: 'Cat',
      location: 'N28 Engineering Block',
      status: 'Healthy',
      date: 'Today, 2:30 PM',
      imageUrl:
          'https://images.unsplash.com/photo-1758607405481-4cfa0341c43d'
          '?w=80&h=80&fit=crop&crop=face',
    ),
    _ProfileReport(
      name: 'Calico',
      type: 'Cat',
      location: 'KRP Library, UTM',
      status: 'Sick',
      date: '2 days ago',
      imageUrl:
          'https://images.unsplash.com/photo-1769942893195-83a935c25d33'
          '?w=80&h=80&fit=crop&crop=face',
    ),
    _ProfileReport(
      name: 'Shadow',
      type: 'Cat',
      location: 'Tasik Danga, UTM',
      status: 'Unknown',
      date: '3 days ago',
      imageUrl:
          'https://images.unsplash.com/photo-1766532280788-2ebac9b44bc6'
          '?w=80&h=80&fit=crop&crop=face',
    ),
  ];

  static const _activityItems = [
    _ActivityItem(
      icon: Icons.photo_camera,
      text: 'You reported Milo at N28 Engineering Block.',
      time: 'Today, 2:30 PM',
    ),
    _ActivityItem(
      icon: Icons.chat_bubble,
      text: "You commented on Luna's profile.",
      time: 'Yesterday, 11:05 AM',
    ),
    _ActivityItem(
      icon: Icons.photo_camera,
      text: 'You reported Calico at KRP Library.',
      time: '2 days ago',
    ),
    _ActivityItem(
      icon: Icons.verified,
      text: 'Your report for Shadow was verified.',
      time: '3 days ago',
    ),
  ];

  void _showEditMessage() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Edit profile is demo-only')));
  }

  void _signOut() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _ProfileHeader(
              avatarUrl: _avatarUrl,
              onBack: () => Navigator.maybePop(context),
              onEdit: _showEditMessage,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
                children: [
                  const _InfoCard(),
                  const SizedBox(height: 18),
                  _ProfileTabs(
                    selectedTab: _selectedTab,
                    onChanged: (tab) => setState(() => _selectedTab = tab),
                  ),
                  const SizedBox(height: 12),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: _selectedTab == _ProfileTab.reports
                        ? const _ReportsList(reports: _reports)
                        : const _ActivityList(items: _activityItems),
                  ),
                  const SizedBox(height: 18),
                  OutlinedButton.icon(
                    onPressed: _signOut,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.error,
                      side: BorderSide(
                        color: AppTheme.error.withValues(alpha: 0.40),
                        width: 1.5,
                      ),
                      backgroundColor: AppTheme.error.withValues(alpha: 0.05),
                      minimumSize: const Size.fromHeight(52),
                    ),
                    icon: const Icon(Icons.logout),
                    label: const Text('Sign Out'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _ProfileTab { reports, activity }

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.avatarUrl,
    required this.onBack,
    required this.onEdit,
  });

  final String avatarUrl;
  final VoidCallback onBack;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.primary,
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
      child: Column(
        children: [
          Row(
            children: [
              _HeaderIconButton(
                tooltip: 'Back',
                icon: Icons.arrow_back,
                onPressed: onBack,
              ),
              const Expanded(
                child: Text(
                  'My Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: onEdit,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white.withValues(alpha: 0.18),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                icon: const Icon(Icons.edit, size: 14),
                label: const Text(
                  'Edit',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            clipBehavior: Clip.none,
            children: [
              _NetworkImageBox(
                imageUrl: avatarUrl,
                width: 78,
                height: 78,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.72),
                  width: 3,
                ),
                fallbackIcon: Icons.person,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.accent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.star, color: Colors.white, size: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Nurul Ain binti Razali',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Volunteer - SPS2250034',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.66),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          const _StatsBar(),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.15),
        foregroundColor: Colors.white,
        fixedSize: const Size(38, 38),
      ),
      icon: Icon(icon, size: 20),
    );
  }
}

class _StatsBar extends StatelessWidget {
  const _StatsBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 310),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
      ),
      child: const Row(
        children: [
          Expanded(
            child: _StatItem(value: '3', label: 'Reports'),
          ),
          SizedBox(
            height: 52,
            child: VerticalDivider(color: Colors.white24, width: 1),
          ),
          Expanded(
            child: _StatItem(value: '1', label: 'Verified'),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.62),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          children: const [
            _InfoRow(
              icon: Icons.person,
              label: 'FULL NAME',
              value: 'Nurul Ain binti Razali',
            ),
            _InfoRow(
              icon: Icons.email,
              label: 'EMAIL',
              value: 'nurulain@graduate.utm.my',
            ),
            _InfoRow(
              icon: Icons.phone,
              label: 'PHONE',
              value: '+60 11-2345 6789',
            ),
            _InfoRow(
              icon: Icons.badge,
              label: 'MATRIC / STAFF ID',
              value: 'SPS2250034',
            ),
            _RoleRow(),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.border)),
      ),
      child: Row(
        children: [
          _InfoIcon(icon: icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppTheme.text.withValues(alpha: 0.42),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppTheme.text,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: AppTheme.text.withValues(alpha: 0.32),
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _RoleRow extends StatelessWidget {
  const _RoleRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          const _InfoIcon(icon: Icons.star, color: AppTheme.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ROLE',
                  style: TextStyle(
                    color: AppTheme.text.withValues(alpha: 0.42),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 6),
                const Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _RoleChip(label: 'Volunteer'),
                    _RoleChip(label: 'Reporter'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoIcon extends StatelessWidget {
  const _InfoIcon({required this.icon, this.color = AppTheme.primary});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }
}

class _RoleChip extends StatelessWidget {
  const _RoleChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.24)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.primary,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs({required this.selectedTab, required this.onChanged});

  final _ProfileTab selectedTab;
  final ValueChanged<_ProfileTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.16)),
      ),
      child: Row(
        children: [
          _ProfileTabButton(
            icon: Icons.photo_camera,
            label: 'My Reports',
            selected: selectedTab == _ProfileTab.reports,
            onPressed: () => onChanged(_ProfileTab.reports),
          ),
          _ProfileTabButton(
            icon: Icons.bolt,
            label: 'Activity',
            selected: selectedTab == _ProfileTab.activity,
            onPressed: () => onChanged(_ProfileTab.activity),
          ),
        ],
      ),
    );
  }
}

class _ProfileTabButton extends StatelessWidget {
  const _ProfileTabButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? Colors.white : AppTheme.primary;

    return Expanded(
      child: Material(
        color: selected ? AppTheme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: foreground),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: foreground,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReportsList extends StatelessWidget {
  const _ReportsList({required this.reports});

  final List<_ProfileReport> reports;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('reports-tab'),
      children: [
        for (final report in reports) ...[
          _ReportCard(report: report),
          if (report != reports.last) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.report});

  final _ProfileReport report;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _NetworkImageBox(
              imageUrl: report.imageUrl,
              width: 48,
              height: 48,
              borderRadius: BorderRadius.circular(14),
              fallbackIcon: Icons.pets,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          report.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppTheme.text,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Text(
                        ' - ${report.type}',
                        style: TextStyle(
                          color: AppTheme.text.withValues(alpha: 0.45),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 13,
                        color: AppTheme.primary,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          report.location,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppTheme.text.withValues(alpha: 0.55),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      StatusChip(status: report.status, compact: true),
                      Text(
                        report.date,
                        style: TextStyle(
                          color: AppTheme.text.withValues(alpha: 0.38),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppTheme.text.withValues(alpha: 0.32),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityList extends StatelessWidget {
  const _ActivityList({required this.items});

  final List<_ActivityItem> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const ValueKey('activity-tab'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          children: [
            for (final item in items)
              _ActivityRow(item: item, showDivider: item != items.last),
          ],
        ),
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.item, required this.showDivider});

  final _ActivityItem item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppTheme.border))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(item.icon, color: AppTheme.primary, size: 17),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.text,
                  style: const TextStyle(
                    color: AppTheme.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.time,
                  style: TextStyle(
                    color: AppTheme.text.withValues(alpha: 0.42),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NetworkImageBox extends StatelessWidget {
  const _NetworkImageBox({
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.fallbackIcon,
    this.border,
  });

  final String imageUrl;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final IconData fallbackIcon;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: borderRadius, border: border),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return _ImageFallback(icon: fallbackIcon);
        },
        errorBuilder: (context, error, stackTrace) {
          return _ImageFallback(icon: fallbackIcon);
        },
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primary.withValues(alpha: 0.18),
            AppTheme.accent.withValues(alpha: 0.16),
          ],
        ),
      ),
      child: Icon(icon, color: AppTheme.primary),
    );
  }
}

class _ProfileReport {
  const _ProfileReport({
    required this.name,
    required this.type,
    required this.location,
    required this.status,
    required this.date,
    required this.imageUrl,
  });

  final String name;
  final String type;
  final String location;
  final String status;
  final String date;
  final String imageUrl;
}

class _ActivityItem {
  const _ActivityItem({
    required this.icon,
    required this.text,
    required this.time,
  });

  final IconData icon;
  final String text;
  final String time;
}
