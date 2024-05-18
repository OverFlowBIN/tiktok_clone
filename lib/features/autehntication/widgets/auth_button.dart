import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final Widget page;

  const AuthButton(
      {super.key, required this.text, required this.icon, required this.page});

// 위젯의 생명 주기에 관련된 메서드들은 앞에 _가 없다.
// 하지만, 위젯의 내부에서만 사용되는 메서드들은 앞에 _가 붙여서 사용한다.(캡슐화)
  void _onNavigationTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // FractionallySizedBox는 부모 위젯의 크기에 따라 자식 위젯의 크기를 조정하는 위젯입니다.
    return GestureDetector(
      onTap: () {
        _onNavigationTap(context);
      },
      child: FractionallySizedBox(
        widthFactor: 1, // 부모 위젯의 가로 길이의 100%(1)를 사용합니다. 0.5이면 50%입니다.
        child: Container(
          padding: const EdgeInsets.all(Sizes.size14),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: Sizes.size1,
            ),
          ),
          // Stack은 위젯을 겹쳐서 배치할 수 있는 위젯입니다.
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
