import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tiktok_clone/features/autehntication/widgets/form_button.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _onSubmitTap() {
    // T? get currentState => ? 마크를 통해 null이 될 수 있습니다.
    // currentState가 null이면 validate()를 호출하지 않습니다.
    // validate()는 boolean값을 반환하고, 그 값을 통해 조건문을 실행 할 수 있다.
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // save()는 FormField의 onSaved를 호출합니다.
        _formKey.currentState!.save();
        print(_formData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Log in")),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Form(

            // Form은 global key가 필요하다.
            // Form의 state에도 접근 할 수 있다.
            // Form의 method를 사용 할 수 있다.
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  // validator는 value(text)값 을 받아서 _onSubmit에서 진행되는
                  // _formKey.currentState?.validate(); 에서 사용됩니다.
                  validator: (value) {
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _formData['email'] = newValue;
                    }
                  },
                ),
                Gaps.v16,
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  validator: (value) {
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _formData['password'] = newValue;
                    }
                  },
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(
                    disabled: false,
                    text: "Log in",
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
