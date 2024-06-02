import 'package:flutter/material.dart';

import '../../constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DefaultTabController는 탭을 사용할 때 사용하는 위젯입니다.
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text('Discover'),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            // splash란 버튼을 눌렀을 때 나타나는 효과를 말합니다.(Material Design의 특징 중 하나인데, 버튼을 눌렀을 때 색이 변하거나 효과가 나타나는 것을 말합니다.)
            // splashFactory: NoSplash.splashFactory를 통해 효과를 없애줍니다.
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            tabs: [for (var tab in tabs) Tab(text: tab)],
          ),
        ),
        body: TabBarView(
          children: [
            for (var tab in tabs)
              Center(
                  child: Text(
                tab,
                style: const TextStyle(
                  fontSize: Sizes.size28,
                ),
              ))
          ],
        ),
      ),
    );
  }
}
