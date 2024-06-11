import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import '../../constants/gaps.dart';
import '../videos/video_timeline_widget.dart';
import 'widgets/post_video_button.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationNavogationState();
}

class _MainNavigationNavogationState extends State<MainNavigationScreen> {
  int _selectIndex = 3;

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
      // resizeToAvoidBottomInset: false는 키보드가 올라왔을때 화면이 줄어드는 것을 방지한다.
      resizeToAvoidBottomInset: false,
      // screens.elementAt(_selectIndex) 과 같이 진행될때는 이전 화면이 뭐였든지 다 지워버리고 있다
      // 항상 선택된 화면만 보여주고 있다.
      // body: screens.elementAt(_selectIndex),
      backgroundColor: _selectIndex == 0 ? Colors.black : Colors.white,
      body: Stack(
        children: [
          // Offstage를 사용하게 되면, 화면을 미리 로딩해놓을 수 있고, 화면을 전환할때 이전의 state를 그대로 유지할 수 있다.
          // 사용자가 해당 화면을 들어오거나 나갔을때는 감지하여 특정 기능을 실행할 수 있다.
          // 하지만, Offstage를 사용하게 되면, 화면이 미리 로딩되어 있기 때문에 메모리를 많이 사용하게 된다.
          Offstage(
            offstage: _selectIndex != 0,
            child: const VedioTimelineScreen(),
          ),
          Offstage(
            offstage: _selectIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectIndex != 4,
            child: Container(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectIndex == 0 ? Colors.black : Colors.white,
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
                selectIndex: _selectIndex,
              ),
              NavTab(
                text: "Discover",
                onTap: () => _onTap(1),
                isSelected: _selectIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                selectIndex: _selectIndex,
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTap,
                child: PostVideoButton(
                  inverted: _selectIndex != 0,
                ),
              ),
              Gaps.h24,
              NavTab(
                text: "Inbox",
                onTap: () => _onTap(3),
                isSelected: _selectIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                selectIndex: _selectIndex,
              ),
              NavTab(
                text: "User",
                onTap: () => _onTap(4),
                isSelected: _selectIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                selectIndex: _selectIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
