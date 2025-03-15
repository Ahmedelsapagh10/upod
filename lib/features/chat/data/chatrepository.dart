import 'dart:io';

import 'chatwebservices.dart';
import 'models/message_model.dart';
import 'models/messages_room_model.dart';
import 'models/register_message.dart';
import 'models/rooms_model.dart';
import 'models/user_data_model.dart';

class ChatRepository {
  ChatWebServices chatWebServices;
  ChatRepository(this.chatWebServices);

  Future<MainRoomModel> roomList() async {
    final messages = await chatWebServices.getRoomList();
    return MainRoomModel.fromJson(messages);
  }

  Future<MainMessagesRoomModel> getMessagesRoomList() async {
    final messages = await chatWebServices.getMessagesRoomList();
    return MainMessagesRoomModel.fromJson(messages);
  }

  Future<MainMessageModel> messagesList(String roomId) async {
    final messages = await chatWebServices.messagesList(roomId);
    return MainMessageModel.fromJson(messages);
  }

  Future<MainMessagesRegisterModel> messageRegister(
      {required String receiverId,
      required File? chatImage,
      required String? content}) async {
    final res = await chatWebServices.messageRegister(
        chatImage: chatImage, receiverId: receiverId, content: content);
    return MainMessagesRegisterModel.fromJson(res);
  }

  Future<MainUserDataModel> getMyUserData() async {
    final res = await chatWebServices.getMyUserData();
    return MainUserDataModel.fromJson(res);
  }
}
