// Flutter imports
import 'package:flutter/material.dart';

// Third-party package imports
import 'package:firebase_core/firebase_core.dart';
import 'package:overlay_support/overlay_support.dart';

// Local imports
import 'package:edumate/firebase_options.dart';
import 'package:edumate/pages/coins.dart';
import 'package:edumate/pages/contest_page.dart';
import 'package:edumate/pages/newhome.dart';
import 'package:edumate/pages/profile_page.dart';
import 'package:edumate/pages/reel/home_page.dart';
import 'package:edumate/pages/skill_page.dart';
import 'package:edumate/pages/splash_page.dart';
import 'package:edumate/src/settings/settings_controller.dart';
import 'package:edumate/src/settings/settings_service.dart';
import 'package:edumate/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/skill': (context) => const SkillScreen(),
          '/profile': (context) => const ProfilePage(),
          '/reels': (context) => const HomeScreen(),
          '/coins': (context) => const Coins(),
          '/contest': (context) => const ContestPage(),
          '/home': (context) => NewHomePage(),
        },
      ),
    );
  }
}
