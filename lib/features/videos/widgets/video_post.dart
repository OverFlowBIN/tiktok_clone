import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../constants/sizes.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost(
      {super.key, required this.onVideoFinished, required this.index});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

// with SingleTickerProviderStateMixin를 사용하면 애니메이션을 사용할 수 있습니다.
class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/center_of_world.mov");

  bool _isPaused = false;

  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.position >=
          _videoPlayerController.value.duration) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    // _videoPlayerController.play();
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      // lowerBound와 upperBound는 scale의 최소, 최대값을 의미합니다.
      lowerBound: 1.0,
      upperBound: 1.5,
      // value는 scale의 초기값을 의미합니다.
      value: 1.5,
      duration: _animationDuration,
    );
    // _animationController의 변경이 있을 때마다 화면을 다시 그리도록 합니다. (강제 build)
    // AnimationBuilder를 사용하면 setState를 사용하지 않아도 됩니다.
    // _animationController.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(
        "${widget.index}",
      ),
      onVisibilityChanged: (info) {
        _onVisibilityChanged(info);
      },
      child: Stack(
        children: [
          // Positioned.fill은 Stack의 모든 영역을 채우는 위젯입니다.
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.teal,
                  ),
          ),
          // Stack안에 동일한 위치에 Positioned.fill이 있을때 Gesture는 z-index 개념이 없기에 그냥 사용할 수 있다.
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
              // IgnorePointer는 자식 위젯에게 터치 이벤트를 무시하도록 합니다.
              child: IgnorePointer(
            child: Center(
              child: AnimatedBuilder(
                animation: _animationController,
                // builder는 _animationController의 값이 변경될 때마다 호출됩니다.
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    // child: child는 AnimatedBuilder의 child를 그대로 반환합니다.
                    child: child,
                  );
                },
                child: AnimatedOpacity(
                  opacity: _isPaused ? 1 : 0,
                  duration: _animationDuration,
                  child: const FaIcon(
                    FontAwesomeIcons.play,
                    color: Colors.white,
                    size: Sizes.size52,
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
