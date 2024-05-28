import 'package:flutter/material.dart';

class VedioTimelineScreen extends StatefulWidget {
  const VedioTimelineScreen({super.key});

  @override
  State<VedioTimelineScreen> createState() => _VedioTimelineScreenState();
}

class _VedioTimelineScreenState extends State<VedioTimelineScreen> {
  final PageController _pageController = PageController();
  int _itemCount = 4;

  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];

  void _onPageChanged(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 5),
      curve: Curves.linear,
    );
    if (index == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      _colors.addAll(
        [
          Colors.blue,
          Colors.red,
          Colors.yellow,
          Colors.teal,
        ],
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // PageView를 사용하면 스크롤 가능한 화면을 만들 수 있습니다.
    // PageView는 모든 페이지를 미리 빌드하여 메모리를 많이 사용하므로 페이지가 많은 경우에는 ListView.builder를 사용하는 것이 좋습니다.
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: _colors.length,
      itemBuilder: (context, index) => Container(
        color: _colors[index],
        child: Center(
          child: Text(
            'Page $index',
            style: const TextStyle(
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}
