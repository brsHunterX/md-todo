import 'package:flutter/material.dart';

import 'package:md_todo/presentation/pages/profile_page.dart';
import 'package:md_todo/presentation/pages/task_list_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _navSelectedIndex = 0;
  
  final PageController _controller = PageController(
    initialPage: 0,
    keepPage: true,
  );
  
  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.checklist_rounded),
      label: 'Mural',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: 'Profile'
    ),
  ];

  Widget _buildPageView() {
    return PageView(
      controller: _controller,
      onPageChanged: (index) => {
        setState(() => _navSelectedIndex = index)
      },
      children: const <Widget>[
        TaskListPage(),
        ProfilePage(),
      ],
    );
  }

  Widget _buildNavigationBar() {
    return BottomNavigationBar(
      items: _navItems,
      currentIndex: _navSelectedIndex,
      onTap: (int index) => {
        _controller.animateToPage(
          index,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 500),
        )
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }
}
