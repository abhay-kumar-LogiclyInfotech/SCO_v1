import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_root_detection_plus/flutter_root_detection_plus.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

class SecurityView extends StatefulWidget {
  final bool isRootedOrJailBroken;
  final bool devMode;

  const SecurityView({
    super.key,
    this.isRootedOrJailBroken = false,
    this.devMode = false,
  });

  /// Static method to check security and navigate
  static Future<void> checkAppSecurityAndNavigate(
      NavigationServices navigationServices) async {
    final rootDetection = FlutterRootDetectionPlus();
    bool isRootedOrJailBroken = false;
    bool devMode = false;

    try {
      isRootedOrJailBroken = await rootDetection.getIsJailBroken();
      if (Platform.isAndroid) {
        devMode = await rootDetection.getIsDevMode();
      }
    } catch (_) {
      isRootedOrJailBroken = false;
      devMode = false;
    }

    // Navigate if any risk is detected
    if (isRootedOrJailBroken || devMode) {
      navigationServices.clearStackAndPush(
        MaterialPageRoute(
          builder: (_) => SecurityView(
            isRootedOrJailBroken: isRootedOrJailBroken,
            devMode: devMode,
          ),
        ),
        // (route) => false,
      );
    }
  }

  @override
  State<SecurityView> createState() => _SecurityViewState();
}

class _SecurityViewState extends State<SecurityView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _checking = true;

  late final bool _isRootedOrJailBroken;
  late final bool _devMode;

  @override
  void initState() {
    super.initState();
    _isRootedOrJailBroken = widget.isRootedOrJailBroken;
    _devMode = widget.devMode;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _startSecurityStatusAnimation();
  }

  Future<void> _startSecurityStatusAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _checking = false);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Device Security Status',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: _checking
          ? const Center(child: CircularProgressIndicator())
          : FadeTransition(
              opacity: _controller,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _SecurityTile(
                      icon: Icons.security,
                      title: Platform.isAndroid
                          ? 'Root Status'
                          : 'Jailbreak Status',
                      subtitle: _isRootedOrJailBroken
                          ? 'Your device is rooted/jailbroken.'
                          : 'Your device is secure.',
                      isDanger: _isRootedOrJailBroken,
                    ),
                    const SizedBox(height: 16),
                    if (Platform.isAndroid)
                      _SecurityTile(
                        icon: Icons.developer_mode,
                        title: 'Developer Mode',
                        subtitle: _devMode
                            ? 'Developer options are enabled.'
                            : 'Developer options are turned off.',
                        isDanger: _devMode,
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Icon(
          Icons.shield_outlined,
          size: 80,
          color: Colors.red,
        ),
        SizedBox(height: 12),
        Text(
          'Security Check Complete',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          'Below is the status of your device\'s security.\n\n'
          'For your safety and data protection, this app requires your device '
          'to be secure. If your device is rooted, jailbroken, or running in '
          'developer mode, access to the app will be restricted.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

class _SecurityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDanger;

  const _SecurityTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isDanger,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDanger ? Colors.red[50] : Colors.green[50];
    final iconColor = isDanger ? Colors.redAccent : Colors.green;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor!, width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        children: [
          Icon(icon, size: 40, color: iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Icon(
            isDanger ? Icons.close : Icons.check_circle,
            color: iconColor,
            size: 28,
          ),
        ],
      ),
    );
  }
}
