import 'package:flutter/material.dart';
import 'main_layout.dart';
import 'theme/app_theme.dart';

import 'services/storage_service.dart';
import 'screens/create_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pint League',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: StorageService().hasProfile() ? const MainLayout() : const CreateProfileScreen(),
    );
  }
}
