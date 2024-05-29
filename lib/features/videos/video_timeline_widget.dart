import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';
import 'package:video_player/video_player.dart';

class VedioTimelineScreen extends StatefulWidget {
  const VedioTimelineScreen({super.key});

  @override
  State<VedioTimelineScreen> createState() => _VedioTimelineScreenState();
}

class _VedioTimelineScreenState extends State<VedioTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();
  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;

  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];

  void _onPageChanged(int index) {
    _pageController.animateToPage(
      index,
      duration: _scrollDuration,
      curve: _scrollCurve,
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

  void _onVideoFinished() {
    _pageController.nextPage(duration: _scrollDuration, curve: _scrollCurve);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
      itemBuilder: (context, index) =>
          VideoPost(onVideoFinished: _onVideoFinished, index: index),
    );
  }
}
