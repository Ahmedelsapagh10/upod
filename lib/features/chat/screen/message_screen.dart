import 'package:academy_lms_app/constants.dart';
import 'package:academy_lms_app/features/chat/cubit/chat_cubit.dart';
import 'package:academy_lms_app/features/chat/cubit/chat_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/message_widget.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen(
      {this.roomId,
      required this.receiverId,
      required this.receiverName,
      super.key});
  final String? roomId;
  final String receiverId;
  final String receiverName;
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    context.read<ChatCubit>().mainMessageModel?.data?.messages = [];
    if (widget.roomId != null) {
      context.read<ChatCubit>().getMessagesList(room: widget.roomId ?? '');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        var cubit = context.read<ChatCubit>();
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            if (widget.roomId != null) {
              cubit.getMessagesRoomList();
            } else {
              cubit.getRoomList();
            }
            return Future<bool>.value(true);
          },
          child: Scaffold(
              backgroundColor: kBackGroundColor,
              appBar: AppBar(
                backgroundColor: kBackGroundColor,
                title: Text(widget.receiverName),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () async {
                    Navigator.pop(context);
                    if (widget.roomId != null) {
                      await cubit.getMessagesRoomList();
                    } else {
                      await cubit.getRoomList();
                    }
                  },
                ),
              ),
              body: Column(
                children: [
                  Flexible(
                      child: (state is LoadingGetMessagesList ||
                              cubit.mainMessageModel == null)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : cubit.mainMessageModel?.data?.messages?.length == 0
                              ? Center(
                                  child: Text('No Messages',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                )
                              : ListView.builder(
                                  controller: cubit.scrollController,
                                  itemCount: cubit
                                      .mainMessageModel?.data?.messages?.length,
                                  itemBuilder: (context, index) {
                                    var message = cubit.mainMessageModel?.data
                                        ?.messages?[index];
                                    return ItemMessage(
                                        message: message,
                                        isMe: message?.senderId ==
                                            cubit.user?['id']);
                                  },
                                )),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 4.0,
                      top: 0.0,
                      bottom: 0.0,
                    ),
                    decoration: BoxDecoration(
                      color: kWhiteColor, // Background color for the text field
                      borderRadius:
                          BorderRadius.circular(5.0), // Rounded corners
                      border: Border.all(
                          color: kBackgroundColor,
                          width: 1.0), // Optional border
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextField(
                            controller: cubit.messageController,

                            decoration: InputDecoration(
                              hintText: 'Type a message...', // Simple hint text
                              border: InputBorder.none,
                              // Remove default borders
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0), // Adjust padding
                            ),
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black), // Text style
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (cubit.messageController.text.isNotEmpty) {
                              cubit.messageRegister(
                                  receiverId: widget.receiverId);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: kDefaultColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.paperplane,
                                  color: kWhiteColor,
                                  size: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 8.0),
                                  child: Text('Send',
                                      style: TextStyle(color: kWhiteColor)),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
