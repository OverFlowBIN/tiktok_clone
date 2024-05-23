import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/stf_screen.dart';

import '../../constants/gaps.dart';
import 'widgets/post_video_button.dart';

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

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Record Video"),
          ),
        ),
        // fullscreenDialog: true를 사용하게 되면, 화면이 전체로 나타나게 된다.
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // CupertinoTabScaffold를 사용하게 되면, index값을 따로 수정해줄 필요가 없다.
    // Cupertino 테마를 올바르게 사용하기 위해서는 main.dart에서 MaterialApp을 CupertinoApp으로 변경해서 사용해야 한다.
    return Scaffold(
      // screens.elementAt(_selectIndex) 과 같이 진행될때는 이전 화면이 뭐였든지 다 지워버리고 있다
      // 항상 선택된 화면만 보여주고 있다.
      // body: screens.elementAt(_selectIndex),

      body: Stack(
        children: [
          // Offstage를 사용하게 되면, 화면을 미리 로딩해놓을 수 있고, 화면을 전환할때 이전의 state를 그대로 유지할 수 있다.
          // 사용자가 해당 화면을 들어오거나 나갔을때는 감지하여 특정 기능을 실행할 수 있다.
          // 하지만, Offstage를 사용하게 되면, 화면이 미리 로딩되어 있기 때문에 메모리를 많이 사용하게 된다.
          Offstage(
            offstage: _selectIndex != 0,
            child: const StfScreen(),
          ),
          Offstage(
            offstage: _selectIndex != 1,
            child: const StfScreen(),
          ),
          Offstage(
            offstage: _selectIndex != 3,
            child: const StfScreen(),
          ),
          Offstage(
            offstage: _selectIndex != 4,
            child: const StfScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(
            Sizes.size12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Gaps.h24,
              GestureDetector(
                  onTap: _onPostVideoButtonTap, child: const PostVideoButton()),
              Gaps.h24,
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
