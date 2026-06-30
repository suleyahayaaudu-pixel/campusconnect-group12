import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_config.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';
import '../messaging/chat_screen.dart';
import '../location/location_screen.dart';
import '../notifications/notification_screen.dart';
import '../offline/offline_screen.dart';
import '../api/api_screen.dart';
import '../scheduling/scheduling_screen.dart';
import '../marketplace/marketplace_screen.dart';
import '../attendance/attendance_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'GOOD MORNING';
    if (hour < 17) return 'GOOD AFTERNOON';
    return 'GOOD EVENING';
  }

  void _logout(BuildContext context) {
    final auth = context.read<AuthProvider>();
    auth.logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void _openScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final services = [
      _ServiceItem(
        icon: Icons.chat_bubble_rounded,
        title: 'Messaging',
        subtitle: 'Real-time chat with typing indicator',
        color: const Color(0xFF5B3FE4),
        screen: const ChatScreen(),
      ),
      _ServiceItem(
        icon: Icons.location_on_rounded,
        title: 'Location Services',
        subtitle: 'Live tracking and geofencing',
        color: const Color(0xFF26A65B),
        screen: const LocationScreen(),
      ),
      _ServiceItem(
        icon: Icons.notifications_rounded,
        title: 'Notifications',
        subtitle: 'Smart alerts and announcements',
        color: const Color(0xFFFF9800),
        screen: const NotificationScreen(),
      ),
      _ServiceItem(
        icon: Icons.storage_rounded,
        title: 'Offline Data',
        subtitle: 'SQLite local cache and sync',
        color: const Color(0xFF8E44AD),
        screen: const OfflineScreen(),
      ),
      _ServiceItem(
        icon: Icons.api_rounded,
        title: 'API Services',
        subtitle: 'REST API integration with retry logic',
        color: const Color(0xFF0097A7),
        screen: const ApiScreen(),
      ),
      _ServiceItem(
        icon: Icons.calendar_month_rounded,
        title: 'Smart Scheduling',
        subtitle: 'AI-optimized timetable generation',
        color: const Color(0xFF1565C0),
        screen: const SchedulingScreen(),
      ),
      _ServiceItem(
        icon: Icons.storefront_rounded,
        title: 'Marketplace',
        subtitle: 'Buy and sell with escrow simulation',
        color: const Color(0xFF8D6E63),
        screen: const MarketplaceScreen(),
      ),
      _ServiceItem(
        icon: Icons.verified_rounded,
        title: 'Attendance Tracker',
        subtitle: 'BLE attendance with minimum stay',
        color: const Color(0xFF3F51B5),
        screen: const AttendanceScreen(),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 78,
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        title: Row(
          children: const [
            SizedBox(width: 8),
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.account_balance_rounded,
                color: Color(0xFF01579B),
                size: 28,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CampusConnect',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'CAM-JAC-12 • Group 12',
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                onPressed: () =>
                    _openScreen(context, const NotificationScreen()),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 6),
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              'YA',
              style: TextStyle(
                color: Color(0xFF01579B),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => _logout(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          final crossAxisCount = isWide ? 4 : 2;

          return ListView(
            padding: const EdgeInsets.all(22),
            children: [
              _HeroCard(greeting: _greeting()),
              const SizedBox(height: 22),
              GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: isWide ? 1.7 : 1.35,
                children: const [
                  _StatCard(
                    icon: Icons.chat_rounded,
                    title: 'Messages',
                    value: '15',
                    note: '12% from yesterday',
                    color: Color(0xFF5B3FE4),
                  ),
                  _StatCard(
                    icon: Icons.notifications_rounded,
                    title: 'Notifications',
                    value: '3',
                    note: '3 new today',
                    color: Color(0xFF2EAD5B),
                  ),
                  _StatCard(
                    icon: Icons.groups_rounded,
                    title: 'Attendance',
                    value: '75%',
                    note: 'Above average',
                    color: Color(0xFFFF9800),
                  ),
                  _StatCard(
                    icon: Icons.shopping_bag_rounded,
                    title: 'Marketplace',
                    value: '4',
                    note: 'Items available',
                    color: Color(0xFF3F7EED),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE2E6F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Campus Services',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'All Services',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      itemCount: services.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: isWide ? 1.25 : 0.95,
                      ),
                      itemBuilder: (context, index) {
                        final service = services[index];

                        return _ServiceCard(
                          item: service,
                          onTap: () => _openScreen(context, service.screen),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              _AnnouncementCard(
                icon: Icons.campaign_rounded,
                title: 'Campus Announcement',
                message:
                    'Welcome to CampusConnect! Stay updated and connected.',
                buttonText: 'View All',
                onTap: () => _openScreen(context, const NotificationScreen()),
              ),
              const SizedBox(height: 18),
              const _FeatureStrip(),
              const SizedBox(height: 18),
              const _FooterText(),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 76,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomItem(
              icon: Icons.home_rounded,
              label: 'Home',
              active: true,
              onTap: () {},
            ),
            _BottomItem(
              icon: Icons.grid_view_rounded,
              label: 'Services',
              active: false,
              onTap: () {},
            ),
            _QrButton(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('QR scanner simulation opened')),
                );
              },
            ),
            _BottomItem(
              icon: Icons.bar_chart_rounded,
              label: 'Analytics',
              active: false,
              onTap: () {},
            ),
            _BottomItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              active: false,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String greeting;

  const _HeroCard({required this.greeting});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            AppConfig.primaryColor,
            const Color(0xFF2736C8),
            const Color(0xFF4C55D9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppConfig.primaryColor.withValues(alpha: 0.25),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -45,
            child: Icon(
              Icons.account_balance_rounded,
              size: 185,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Yahaya Sule Audu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Federal University Dutse',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Your Smart Campus Companion',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Spacer(),
              const Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _StatusChip(
                    icon: Icons.circle,
                    color: Colors.greenAccent,
                    text: 'Online',
                  ),
                  _StatusChip(
                    icon: Icons.security,
                    color: Colors.orangeAccent,
                    text: 'Secure',
                  ),
                  _StatusChip(
                    icon: Icons.cloud_done,
                    color: Colors.lightBlueAccent,
                    text: 'Connected',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _StatusChip({
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String note;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.note,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E6F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withValues(alpha: 0.14),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  note,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
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

class _ServiceItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Widget screen;

  const _ServiceItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.screen,
  });
}

class _ServiceCard extends StatelessWidget {
  final _ServiceItem item;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFE2E6F0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(item.icon, color: item.color, size: 33),
              ),
              const SizedBox(height: 14),
              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 7),
              Text(
                item.subtitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Open',
                    style: TextStyle(
                      color: item.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 17,
                    color: item.color,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onTap;

  const _AnnouncementCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E6F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppConfig.primaryColor.withValues(alpha: 0.12),
            child: Icon(icon, color: AppConfig.primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppConfig.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(onPressed: onTap, child: Text(buttonText)),
        ],
      ),
    );
  }
}

class _FeatureStrip extends StatelessWidget {
  const _FeatureStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E6F0)),
      ),
      child: const Row(
        children: [
          Expanded(
            child: _MiniFeature(
              icon: Icons.security_rounded,
              title: 'Secure & Private',
              subtitle: 'Protected campus data',
            ),
          ),
          _VerticalDivider(),
          Expanded(
            child: _MiniFeature(
              icon: Icons.cloud_done_rounded,
              title: 'Always Available',
              subtitle: 'Online and offline support',
            ),
          ),
          _VerticalDivider(),
          Expanded(
            child: _MiniFeature(
              icon: Icons.groups_rounded,
              title: 'Built for Students',
              subtitle: 'Designed for FUD students',
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _MiniFeature({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(height: 55, width: 1, color: const Color(0xFFE2E6F0));
  }
}

class _FooterText extends StatelessWidget {
  const _FooterText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'CampusConnect v1.0\nSoftware Engineering Department\nFederal University Dutse\n2025/2026 Session',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black45,
        fontSize: 12,
        height: 1.5,
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _BottomItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppConfig.primaryColor : Colors.grey.shade600;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 78,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QrButton extends StatelessWidget {
  final VoidCallback onTap;

  const _QrButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -18),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppConfig.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppConfig.primaryColor.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.qr_code_scanner_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
