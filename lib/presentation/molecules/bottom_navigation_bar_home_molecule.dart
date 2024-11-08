import 'package:flutter/material.dart';

class BottomNavigationBarHomePage extends StatelessWidget {
  const BottomNavigationBarHomePage(this.callback, this.pageIndex);

  final Function(int) callback;

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    return BottomNavigationBar(
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      currentIndex: pageIndex,
      onTap: callback,
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.timer),
          icon: Icon(Icons.timer),
          label: 'Timer',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.text_snippet),
          icon: Icon(Icons.text_snippet),
          label: 'Notes',
        ),
      ],
    );
  }
}
