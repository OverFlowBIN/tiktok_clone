import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notification = List.generate(
    20,
    (index) => "${index}h",
  );

  final List<Map<String, dynamic>> _tabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    }
  ];

  // late를 붙이게 되면 변수를 초기화하지 않아도 됨
  // SingleTickerProviderStateMixin을 사용하여 AnimationController를 가져왔을 때는
  // (이렇게 this나, 다른 instance memeber를 참조라는 경우)
  // late를 붙여야 한다.
  // 결론적으로 class가 생성되면 AnimationController는 초기화 되지 않은 상태가 되고,
  // initState에서 초기화가 된다.
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  // Animation을 사용 하면 setState나, Animation Builder를 사용하지 않아도 된다
  // Tween을 사용하여 애니메이션을 정의할 수 있다.
  // begin은 시작점, end는 끝점
  late final Animation<double> _arrowAnimation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

  late final Animation<Color?> _barrierAnimation =
      ColorTween(begin: Colors.transparent, end: Colors.black38)
          .animate(_animationController);

  // Animation<Offset>을 사용하면 SlideTransition을 사용할 수 있다.
  // SlideTransition은 child를 이동시키는 위젯
  late final Animation<Offset> _panelAnimation = Tween(
    begin: const Offset(0, -1.0),
    end: Offset.zero,
  ).animate(_animationController);

  bool _showBarrier = false;

  void _onDismissed(String notification) {
    _notification.remove(notification);
    setState(() {});
  }

  void _toggleAnimations() async {
    _animationController.isCompleted
        // _animationController.reverse()는 Future를 반환하기 때문에 await를 사용할 수 있다.
        ? await _animationController.reverse()
        : _animationController.forward();

    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All activity"),
              Gaps.h2,
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      // Dismissible은 스와이프로 삭제할 수 있는 위젯
      // 스와이프 방향에 따라 다른 방식의 이벤트를 처리할 수 있음
      // Dismissible를 이용해서 widget을 삭제하는 경우 build 메소드 안에서 데이터를 삭제해야 된다.

      // ListView와 SlideTrasition을 Stack으로 감싸서 SlideTrasition이 ListView 위에 나타나도록 함
      // Stack의 children은 나중에 나오는 위젯이 더 위에 나타난다
      body: Stack(
        children: [
          ListView(
            // padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            padding: const EdgeInsets.symmetric(horizontal: 0),
            children: [
              Gaps.v14,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
                child: Text(
                  'New',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gaps.v14,
              for (var notification in _notification)
                Dismissible(
                  key: Key(notification),
                  onDismissed: (direction) => _onDismissed(notification),
                  background: Container(
                    // Container안에 alignment를 주면 child의 위치를 조정할 수 있음
                    alignment: Alignment.centerLeft,
                    color: Colors.green,
                    child: const Padding(
                      padding: EdgeInsets.only(left: Sizes.size10),
                      child: FaIcon(
                        FontAwesomeIcons.checkDouble,
                        color: Colors.white,
                        size: Sizes.size40,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    // Container안에 alignment를 주면 child의 위치를 조정할 수 있음
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(right: Sizes.size10),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                        size: Sizes.size40,
                      ),
                    ),
                  ),
                  child: ListTile(
                    // minVerticalPadding는 ListTile의 위아래 padding을 조정할 수 있음
                    minVerticalPadding: Sizes.size16,
                    // contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: Sizes.size52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: Sizes.size1,
                        ),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: "Account updates:",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: Sizes.size16,
                        ),
                        children: [
                          const TextSpan(
                            text: " Upload longer videos",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: " $notification",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const FaIcon(FontAwesomeIcons.chevronRight,
                        size: Sizes.size16),
                  ),
                ),
            ],
          ),
          // SlideTransition은 child를 이동시키는 위젯
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              // dismissible은 true로 설정하면 barrier를 클릭하면 애니메이션이 실행됨
              dismissible: true,
              onDismiss: _toggleAnimations,
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    Sizes.size5,
                  ),
                  bottomRight: Radius.circular(
                    Sizes.size5,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          FaIcon(
                            tab["icon"],
                            color: Colors.black,
                            size: Sizes.size16,
                          ),
                          Gaps.h20,
                          Text(
                            tab["title"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
