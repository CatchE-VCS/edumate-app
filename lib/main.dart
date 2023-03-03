import 'package:edumate/pages/coins.dart';
import 'package:edumate/pages/profile_page.dart';
import 'package:edumate/pages/reel/home_page.dart';
import 'package:edumate/pages/skill_page.dart';
import 'package:edumate/pages/splashScreen.dart';
import 'package:edumate/src/settings/settings_controller.dart';
import 'package:edumate/src/settings/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'themes/themes.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(MyApp(
    settingsController: settingsController,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsController});
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Flutter Demo',
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/skill': (context) => const SkillScreen(),
          '/profile': (context) => const ProfilePage(),
          '/reels': (context) => const HomeScreen(),
          '/coins': (context) => const Coins(),
        },
      ),
    );
  }
}
