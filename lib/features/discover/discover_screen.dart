import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';

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

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin은 애니메이션을 사용할 때 사용하는 Mixin입니다.
  // TabController를 사용할 때는 SingleTickerProviderStateMixin을 사용해야 합니다.

  final TextEditingController _searchController = TextEditingController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    // 탭 변경 시 호출되는 콜백
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // 포커스를 제거하여 키보드를 닫음
        FocusScope.of(context).unfocus();
      }
    });
  }

  void _onSearchChanged(String value) {
    print("Search changed: $value");
  }

  void _onSearchSubmitted(String value) {
    print("Search Submitted: $value");
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DefaultTabController는 탭을 사용할 때 사용하는 위젯입니다.

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        // resizeToAvoidBottomInset는 키보드가 나타날 때 화면이 줄어드는 것을 막아줍니다.
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          title: SizedBox(
            height: Sizes.size36,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                // contentPadding는 TextField의 내부 여백을 설정합니다.
                contentPadding: const EdgeInsets.symmetric(
                    vertical: Sizes.size10, horizontal: Sizes.size2),
                // isDense는 TextField의 여백을 줄여주는 역할을 합니다.
                // isDense: true,
                fillColor: Colors.grey.shade200,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
                hintText: "Search",
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                suffixIcon: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.solidCircleXmark,
                    color: Colors.grey.shade500,
                    size: Sizes.size16,
                  ),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
              ),
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
            ),
          ),
          // title: CupertinoSearchTextField(
          //   // CupertinoSearchTextField는 iOS의 검색창을 구현한 위젯입니다.
          //   // CupertinoSearchTextField의 텍스트 커서 색상 변경은 불가하므로,
          //   // main.dart에서 테마(전체 inputFiled)를 변경해야 한다.
          //   controller: _searchController,
          //   onChanged: _onSearchChanged,
          //   onSubmitted: _onSearchSubmitted,
          // ),
          bottom: TabBar(
            controller: _tabController,
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
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(
                Sizes.size6,
              ),
              itemCount: 20,
              // gridDelegate는 그리드의 모양을 정하는 것입니다.
              // SliverGridDelegateWithFixedCrossAxisCount는 그리드의 가로 길이를 정하는 것입니다.
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Sizes.size8,
                mainAxisSpacing: Sizes.size8,
                childAspectRatio: 9 / 20,
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    // clipBehavior를 사용하지 않으면 이미지가 컨테이너를 벗어나게 되어,
                    // borderRadius가 적용되지 않습니다.
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Sizes.size4,
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/IMG_4774.jpg",
                          image:
                              "https://flexible.img.hani.co.kr/flexible/normal/640/484/imgdb/resize/2015/0718/00535983901_20150718.JPG"),
                    ),
                  ),
                  Gaps.v10,
                  const Text(
                    "Universe is so big and beautiful. Universe is so big and beautiful.Universe is so big and beautiful.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Sizes.size16 + Sizes.size2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v5,
                  // DefaultTextStyle을 사용하면 해당 영역에 텍스트 스타일을 한번에 적용할 수 있습니다.
                  DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: Sizes.size14,
                          backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/87470206?v=4"),
                        ),
                        Gaps.h4,
                        // Expanded는 오직 해당 Row 내부에서 가능한 최대의 공간을 차지하도록 합니다.
                        const Expanded(
                          child: Text(
                            "OverFlowBIN_TikTok_20240605",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gaps.h4,
                        FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size16,
                          color: Colors.grey.shade500,
                        ),
                        Gaps.h2,
                        const Text(
                          "1.2M",
                        ),
                      ],
                    ),
                  )
                ],
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
