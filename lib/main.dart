import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/playground_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const MomentRouteTrainingApp());
}

class MomentRouteTrainingApp extends StatelessWidget {
  const MomentRouteTrainingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moment Route Training',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF3F2EF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF48564D),
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: Color(0xFFE4E2DD)),
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _showScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        onOpenProfile: () => _showScreen(1),
        onOpenPlayground: () => _showScreen(2),
      ),
      const ProfileScreen(),
      const PlaygroundScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: screens),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _showScreen,
              height: 68,
              backgroundColor: const Color(0xFF252B27),
              indicatorColor: const Color(0xFFDDE5DF),
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined, color: Colors.white70),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: '홈',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white70,
                  ),
                  selectedIcon: Icon(Icons.person_rounded),
                  label: '프로필',
                ),
                NavigationDestination(
                  icon: Icon(Icons.extension_outlined, color: Colors.white70),
                  selectedIcon: Icon(Icons.extension_rounded),
                  label: '연습장',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
