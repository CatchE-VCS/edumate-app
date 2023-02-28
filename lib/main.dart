import 'package:flutter/material.dart';
import 'package:edumate/src/settings/settings_controller.dart';
import 'package:edumate/src/settings/settings_service.dart';
import 'package:overlay_support/overlay_support.dart';
import 'pages/home_page.dart';
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
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
