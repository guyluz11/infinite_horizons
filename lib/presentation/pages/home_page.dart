import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTabNum = 0;

  final _tabs = [
    TimerOrganism(),
    TextAreaOrganism(),
  ];

  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void callback(int index) {
    setState(() {
      _currentTabNum = index;
      _pageController.animateToPage(
        _currentTabNum,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            if (index == 0){
              FocusScope.of(context).unfocus();
            }
            _currentTabNum = index;
          });
        },
        controller: _pageController,
        children: _tabs,
      ),
      bottomNavigationBar:
          BottomNavigationBarHomePage(callback, _currentTabNum),
    );
  }
}
