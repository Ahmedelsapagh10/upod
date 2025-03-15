import 'package:academy_lms_app/constants.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/models/message_model.dart';

class ItemMessage extends StatefulWidget {
  ItemMessage({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  Message? message;
  final bool isMe;
  @override
  State<ItemMessage> createState() => _ItemMessageState();
}

class _ItemMessageState extends State<ItemMessage> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(
          left: widget.isMe ? 100 : 10,
          right: widget.isMe ? 10 : 100,
          bottom: 5,
          top: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: widget.isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
          color: widget.isMe ? kBlueColor : Colors.grey.shade300,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 2, left: 2, right: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Container(
                alignment:
                    widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
                padding: EdgeInsets.only(top: 1.0, left: 12, right: 12),
                child: Text(
                  DateFormat("hh:mm a").format(
                      widget.message?.createdAt?.toLocal() ??
                          DateTime.now().toLocal()),
                  textAlign: widget.isMe ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                      fontSize: 10,
                      color: !widget.isMe ? kGreyLightColor : kBackgroundColor),
                ),
              ),
              Flexible(
                child: Text(
                  widget.message?.message ?? '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color:
                          !widget.isMe ? kBackButtonBorderColor : kWhiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
