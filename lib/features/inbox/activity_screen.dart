import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  // late를 붙이게 되면 변수를 초기화하지 않아도 됨
  // SingleTickerProviderStateMixin을 사용하여 AnimationController를 가져왔을 때는
  // (이렇게 this나, 다른 instance memeber를 참조라는 경우)
  // late를 붙여야 한다.
  // 결론적으로 class가 생성되면 AnimationController는 초기화 되지 않은 상태가 되고,
  // initState에서 초기화가 된다.
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  // Animation을 사용 하면 setState나, Animation Builder를 사용하지 않아도 된다
  late final Animation<double> _animation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

  void _onDismissed(String notification) {
    print(notification);
    _notification.remove(notification);
    setState(() {});
  }

  void _onTitleTap() {
    _animationController.isCompleted
        ? _animationController.reverse()
        : _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTitleTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All activity"),
              Gaps.h2,
              RotationTransition(
                turns: _animation,
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
      body: ListView(
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
    );
  }
}
