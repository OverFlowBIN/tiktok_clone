import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/autehntication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'email_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  // 2024-05-19 21:15:22.176700
  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _setTextFiledDate(initialDate);
  }

  @override
  void dispose() {
    // 컨트롤러를 dispose해서 메모리 누수를 방지합니다.
    _birthdayController.dispose();
    // super.initState()와 다르게 super.dispose()는 마지막에 호출하는게 좀 더 좋은 방법이다.
    super.dispose();
  }

  void _onNextTap() {
    // StatefulWidget 안의 State 안에 있다면 어디서든 context를 사용할 수 있습니다.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
      (route) => false,
    );
  }

  void _setTextFiledDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(
      text: textDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 여기서 main.dart 의 테마가 적용이 안되는 이유는 ?
      // MaterialApp의 테마는 MaterialApp의 자식 위젯에만 적용이 됩니다.
      appBar: AppBar(
        title: const Text(
          'Sign up',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "When's your birthday?",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              "Ypur birthday won't be shared publicly.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v16,
            TextField(
              enabled: false,
              controller: _birthdayController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v16,
            GestureDetector(
                onTap: _onNextTap,
                child: const FormButton(
                  disabled: false,
                  text: 'Next',
                ))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300,
        child: CupertinoDatePicker(
          maximumDate: initialDate.subtract(const Duration(days: 365 * 12)),
          initialDateTime: DateTime.parse('2000-01-01 00:00:00.000000'),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: _setTextFiledDate,
        ),
      ),
    );
  }
}
