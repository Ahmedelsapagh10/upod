import 'package:academy_lms_app/constants.dart';
import 'package:academy_lms_app/features/chat/cubit/chat_cubit.dart';
import 'package:academy_lms_app/features/chat/cubit/chat_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'message_screen.dart';

class MainRoomsScreen extends StatefulWidget {
  const MainRoomsScreen({super.key});

  @override
  State<MainRoomsScreen> createState() => _MainRoomsScreenState();
}

class _MainRoomsScreenState extends State<MainRoomsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    context.read<ChatCubit>().getRoomList();
    context.read<ChatCubit>().getMessagesRoomList();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        var cubit = context.read<ChatCubit>();
        return Scaffold(
          backgroundColor: kWhiteColor,
          appBar: AppBar(
            backgroundColor: kWhiteColor,
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Messages'),
                Tab(text: 'Admins'),
              ],
            ),
          ),
          body: (state is LoadingGetRoomList || cubit.mainRoomModel == null)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(
                  controller: _tabController,
                  children: [
                    // Messages Tab
                    _buildMessageRoomList(cubit),
                    // Admins Tab
                    _buildRoomList(cubit),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildRoomList(ChatCubit cubit) {
    return ListView.builder(
      itemCount: cubit.mainRoomModel?.data?.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        var item = cubit.mainRoomModel?.data?[index];
        return InkWell(
          splashColor: kDefaultColor,
          onTap: () {
            print('PPPPPPP Me: ${cubit.user?['id']}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MessageScreen(
                          receiverName: item?.name.toString() ?? '',
                          receiverId: item?.id.toString() ?? '1',
                        )));
          },
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                color: Colors.grey.shade200,
              )
            ], borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: cubit.mainRoomModel?.data?[index].photo == null
                      ? CircleAvatar(
                          backgroundColor: kDefaultColor,
                          backgroundImage:
                              AssetImage('assets/images/app_icon.png'))
                      : CircleAvatar(
                          backgroundColor: kDefaultColor,
                          backgroundImage: NetworkImage(
                              cubit.mainRoomModel?.data?[index].photo),
                        ),
                ),
                Flexible(
                    child: Text(
                  cubit.mainRoomModel?.data?[index].name ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageRoomList(ChatCubit cubit) {
    return ListView.builder(
      itemCount: cubit.mainMessagesRoomModel?.data?.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        var item = cubit.mainMessagesRoomModel?.data?[index];
        return InkWell(
          splashColor: kDefaultColor,
          onTap: () {
            print(
                'PPPPPPP receiverId: ${item?.contactOne?.id == cubit.user?['id'] ? item?.contactTwo?.id.toString() ?? '' : item?.contactOne?.id.toString() ?? ''}');
            print('PPPPPPP Me: ${cubit.user?['id']}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MessageScreen(
                          receiverName:
                              item?.contactOne?.id == cubit.user?['id']
                                  ? item?.contactTwo?.name.toString() ?? ''
                                  : item?.contactOne?.name.toString() ?? '',
                          roomId: item?.code,
                          receiverId: item?.contactOne?.id == cubit.user?['id']
                              ? item?.contactTwo?.id.toString() ?? ''
                              : item?.contactOne?.id.toString() ?? '',
                        )));
          },
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                color: Colors.grey.shade200,
              )
            ], borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: item?.contactOne?.id == cubit.user?['id']
                      ? item?.contactTwo?.photo == null
                          ? CircleAvatar(
                              backgroundColor: kDefaultColor,
                              backgroundImage:
                                  AssetImage('assets/images/app_icon.png'))
                          : CircleAvatar(
                              backgroundColor: kDefaultColor,
                              backgroundImage:
                                  NetworkImage(item?.contactTwo?.photo ?? ''),
                            )
                      : item?.contactOne?.photo == null
                          ? CircleAvatar(
                              backgroundColor: kDefaultColor,
                              backgroundImage:
                                  AssetImage('assets/images/app_icon.png'))
                          : CircleAvatar(
                              backgroundColor: kDefaultColor,
                              backgroundImage:
                                  NetworkImage(item?.contactOne?.photo ?? ''),
                            ),
                ),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item?.contactOne?.id == cubit.user?['id']
                          ? item?.contactTwo?.name ?? ''
                          : item?.contactOne?.name ?? '',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      item?.lastMessage?.message ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
