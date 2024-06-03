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
            // GridView보다 GridView.builder를 사용하는 이유는
            // GridView는 모든 아이템을 한 번에 생성하기 때문에 성능이 떨어질 수 있습니다.
            // 하지만, GridView.builder는 스크롤을 할 때 아이템을 생성하기 때문에 성능이 좋습니다.
            GridView.builder(
              padding: const EdgeInsets.all(
                Sizes.size6,
              ),

              itemCount: 20,
              // gridDelegate는 그리드의 모양을 정하는 것입니다.
              // SliverGridDelegateWithFixedCrossAxisCount는 그리드의 가로 길이를 정하는 것입니다.
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 16,
              ),
              itemBuilder: (context, index) => Container(
                color: Colors.teal,
                child: Center(
                  child: Text("$index"),
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: Sizes.size28,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
