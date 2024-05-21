import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/stf_screen.dart';

class MainNavigationNavogation extends StatefulWidget {
  const MainNavigationNavogation({super.key});

  @override
  State<MainNavigationNavogation> createState() =>
      _MainNavigationNavogationState();
}

class _MainNavigationNavogationState extends State<MainNavigationNavogation> {
  int _selectIndex = 0;

  final screens = [
    StfScreen(key: GlobalKey()),
    StfScreen(key: GlobalKey()),
    Container(),
    StfScreen(key: GlobalKey()),
    StfScreen(key: GlobalKey()),
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
    return Scaffold(
      // screens.elementAt(_selectIndex) 과 같이 진행될때는 이전 화면이 뭐였든지 다 지워버리고 있다
      // 항상 선택된 화면만 보여주고 있다. 
      body: screens.elementAt(_selectIndex),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(
            Sizes.size12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavTab(
                text: "Home",
                onTap: () => _onTap(0),
                isSelected: _selectIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
              ),
              NavTab(
                text: "Discover",
                onTap: () => _onTap(1),
                isSelected: _selectIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
              ),
              NavTab(
                text: "Inbox",
                onTap: () => _onTap(3),
                isSelected: _selectIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
              ),
              NavTab(
                text: "User",
                onTap: () => _onTap(4),
                isSelected: _selectIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
