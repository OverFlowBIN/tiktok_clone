import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text('12323 Comments'),
          actions: [
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.xmark,
              ),
              onPressed: _onClosePressed,
            )
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
            horizontal: Sizes.size16,
          ),
          itemCount: 10,
          separatorBuilder: (context, index) => Gaps.v20,
          itemBuilder: (context, index) => Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 18,
                  child: Text("OB"),
                ),
                Gaps.h8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'OverFlowBIN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      Gaps.v4,
                      const Text(
                          "That's not it I'm not sure about thisThat's not it I'm not sure about thisThat's not it I'm not sure about thisThat's not it I'm not sure about thisThat's not it I'm not sure about this"),
                    ],
                  ),
                ),
                Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.heart,
                      size: Sizes.size20,
                      color: Colors.grey.shade500,
                    ),
                    Gaps.v2,
                    Text(
                      '1.2M',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade500,
                foregroundColor: Colors.white,
                child: const Text("OB"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
