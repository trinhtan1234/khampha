import 'package:flutter/material.dart';

import 'map/bandoso.dart';

class MenuKhungApp extends StatefulWidget {
  const MenuKhungApp({super.key});

  @override
  State<MenuKhungApp> createState() => _MenuKhungAppState();
}

class _MenuKhungAppState extends State<MenuKhungApp> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _pages = [
      const BanDoSo(),
      const Text('Bổ sung'),
      const Text('Tài khoản'),
      // const HomePage(),
      // const PostCasts(),
      // const MyVnE(),
      // const TienIch(),
      // const Menu(),
    ];
  }

  List<Widget> _pages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Khám phá'),
          BottomNavigationBarItem(
              icon: Icon(Icons.pin_drop_sharp), label: 'Bổ sung'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded), label: 'Tài khoản'),
        ],
      ),
    );
  }
}
