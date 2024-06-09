import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<String> _notification = List.generate(
    20,
    (index) => "${index}h",
  );

  void _onDismissed(String notification) {
    print(notification);
    _notification.remove(notification);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All activity"),
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
