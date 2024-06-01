import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/gaps.dart';

class NavTab extends StatelessWidget {
  const NavTab(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.icon,
      required this.onTap,
      required this.selectedIcon,
      required this.selectIndex});

  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTap;
  final int selectIndex;

  @override
  Widget build(BuildContext context) {
    // Expanded를 넣게되면 하위 widget에서 UI를 차지하는 Container를 꽉 채울 수 있다.
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        // Container를 추가하여 버튼을 클릭할 수 있는 영역을 넓힐 수 있다.
        child: Container(
          color: selectIndex == 0 ? Colors.black : Colors.white,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(microseconds: 300),
            child: Column(
              // mainAxisSize를 정하지 않는다면 Column이라는 세로축으로 최대한 확장하려 하기 때문에 전체를 차지하게 된다.
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: selectIndex == 0 ? Colors.white : Colors.black,
                ),
                Gaps.v5,
                Text(
                  text,
                  style: TextStyle(
                    color: selectIndex == 0 ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
