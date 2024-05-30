import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../constants/gaps.dart';
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
// with SingleTickerProviderStateMixin은 해당 class의 프로퍼티와 메소드를 사용할 수 있도록 합니다.(확장하지 않고)
// SingleTickerProviderStateMixin가 필요한 이유
// 1. 애니메이션을 사용할 때 TickerProvider를 사용해야 합니다.(프레임 마다 애니메이션을 그리기 위해 필요합니다.)
// 2. current tree가 활성화 되어있을때만 애니메이션을 그리기 위해 필요합니다.
// 여러개의 Ticker가 필요하면 TickerProviderStateMixin을 사용합니다.
class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

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
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/center_of_world.mov");
    await _videoPlayerController.initialize();
    // _videoPlayerController.play();
    await _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      // vsync는 애니메이션이 화면에 그려질 때 애니메이션을 동기화하는 역할을 합니다.
      // 그리고 offscreen일 때 애니메이션을 멈추는 역할을 합니다.(메모리 절약)
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
    // info.visibleFraction == 1은 화면에 완전히 보이는 것을 의미합니다.
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
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

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    // showModalBottomSheet은 Future를 반환합니다.
    // await를 사용하면 showModalBottomSheet이 닫힐 때까지 기다립니다.
    await showModalBottomSheet(
      context: context,
      builder: (context) => const VideoComments(),
      // backgroundColor: Colors.transparent 는 배경을 투명하게 만듭니다.
      // 이렇게 하면 showModalBottomSheet내에 container를 두고 rouded border를 적용할 수 있습니다.
      backgroundColor: Colors.transparent,
    );
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
          )),
          const Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@OverFlowBIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                Text(
                  'This is my house askdjksd',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/87470206?v=4"),
                  child: Text("OB"),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "2.9M",
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "1.2M",
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "3.4M",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
