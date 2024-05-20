import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationNavogation extends StatefulWidget {
  const MainNavigationNavogation({super.key});

  @override
  State<MainNavigationNavogation> createState() =>
      _MainNavigationNavogationState();
}

class _MainNavigationNavogationState extends State<MainNavigationNavogation> {
  int _selectIndex = 0;

  final screens = [
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Search"),
    ),
    const Center(
      child: Text("Setting"),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // CupertinoTabScaffold를 사용하게 되면, index값을 따로 수정해줄 필요가 없다.
    // Cupertino 테마를 올바르게 사용하기 위해서는 main.dart에서 MaterialApp을 CupertinoApp으로 변경해서 사용해야 한다.
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              // CupertinoIcons를 사용하게 되면 조금 더 IOS 처럼 표현된다
              CupertinoIcons.house,
              semanticLabel: "Home",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.search,
              semanticLabel: "Search",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.settings,
              semanticLabel: "Setting",
            ),
          ),
        ],
      ),
      tabBuilder: (context, index) => screens[index],
    );
  }
}
