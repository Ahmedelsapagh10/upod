// ignore_for_file: unused_element

import 'package:academy_lms_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './custom_text.dart';

class AccountListTile extends StatelessWidget {
  final String? titleText;
  final String? icon;
  final String? actionType;
  final String? courseAccessibility;
  final bool isChat;
  const AccountListTile({
    super.key,
    @required this.titleText,
    @required this.icon,
    this.isChat = false,
    @required this.actionType,
    this.courseAccessibility,
  });

  void _actionHandler(BuildContext context) {
    // condition and navigations
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(6),
        child: FittedBox(
          child: isChat
              ? Icon(
                  CupertinoIcons.chat_bubble_text_fill,
                  color: kDefaultColor,
                )
              : SvgPicture.asset(
                  icon!,
                  color: kDefaultColor,
                ),
        ),
      ),
      title: CustomText(
        text: titleText,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      trailing:
          //  IconButton(
          //   icon:
          const Icon(
        Icons.arrow_forward_ios,
        size: 18,
      ),
      // iconSize: 18,
      // onPressed: () => _actionHandler(context),
      // ),
    );
  }
}
