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

class _VideoPostState extends State<VideoPost> {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/center_of_world.mov");

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
    } else {
      _videoPlayerController.play();
    }
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
          const Positioned.fill(
              // IgnorePointer는 자식 위젯에게 터치 이벤트를 무시하도록 합니다.
              child: IgnorePointer(
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.play,
                color: Colors.white,
                size: Sizes.size52,
              ),
            ),
          ))
        ],
      ),
    );
  }
}
