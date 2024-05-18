import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;

  const AuthButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // FractionallySizedBox는 부모 위젯의 크기에 따라 자식 위젯의 크기를 조정하는 위젯입니다.
    return FractionallySizedBox(
      widthFactor: 1, // 부모 위젯의 가로 길이의 100%(1)를 사용합니다. 0.5이면 50%입니다.
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size14),
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.grey.shade300,
          width: Sizes.size1,
        )),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
