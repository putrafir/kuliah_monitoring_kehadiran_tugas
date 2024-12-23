import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/history.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/providers/Kehadiran.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Kehadiran(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MybottomNavigation(),
    );
  }
}

class MybottomNavigation extends StatefulWidget {
  const MybottomNavigation({super.key});

  @override
  State<MybottomNavigation> createState() => _MybottomNavigationState();
}

class _MybottomNavigationState extends State<MybottomNavigation> {
  int _currentIndex = 0;
  final _pages = [Home(), History()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.edit), label: 'Pencatatan'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Riwayat'),
          ]),
    );
  }
}
