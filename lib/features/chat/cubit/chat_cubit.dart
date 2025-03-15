import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/common_functions.dart';
import '../data/chatrepository.dart';
import '../data/models/message_model.dart';

import '../data/models/messages_room_model.dart';
import '../data/models/rooms_model.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepository) : super(InitChatState()) {
    getData();
  }
  ChatRepository chatRepository;

  MainMessageModel? mainMessageModel;

  Future<void> getMessagesList({
    required String room,
  }) async {
    emit(LoadingGetMessagesList());
    return chatRepository.messagesList(room).then((messagess) {
      mainMessageModel = messagess;
      scrollToLastMessage();

      emit(SuccessGetMessagesList());
    }).onError((error, stackTrace) {
      emit(ErrorGetMessagesList());
    });
  }

  messageRegister({required String receiverId}) {
    emit(LoadingAddNewMessage());
    return chatRepository
        .messageRegister(
            receiverId: receiverId,
            chatImage: myImage,
            content: messageController.text)
        .then((e) {
      messageController.clear();
      getMessagesList(room: e.threadCode ?? '').then((m) {
        SchedulerBinding.instance
            .addPostFrameCallback((_) => scrollToLastMessage());
      });

      myImage = null;
      emit(SuccessAddNewMessage());
    }).onError((error, stackTrace) {
      CommonFunctions.showWarningToast(error.toString());
    });
  }

  MainRoomModel? mainRoomModel;
  getRoomList() {
    emit(LoadingGetRoomList());

    return chatRepository.roomList().then((fetchedRooms) {
      print('sssssssssssssss${fetchedRooms.toString()}');

      mainRoomModel = fetchedRooms;

      emit(SuccessGetRoomList());
    }).onError((error, stackTrace) {
      print(error.toString());
      CommonFunctions.showWarningToast(error.toString());
      emit(ErrorGetRoomList());
    });
  }

  MainMessagesRoomModel? mainMessagesRoomModel;
  getMessagesRoomList() {
    emit(LoadingGetRoomList());

    return chatRepository.getMessagesRoomList().then((fetchedRooms) {
      print('xxxxxx ${fetchedRooms.toString()}');

      mainMessagesRoomModel = fetchedRooms;

      emit(SuccessGetRoomList());
    }).onError((error, stackTrace) {
      print(error.toString());
      CommonFunctions.showWarningToast(error.toString());
      emit(ErrorGetRoomList());
    });
  }
  //!

  TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void scrollToLastMessage() {
    //scrollController.position.maxScrollExtent
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

//add image
  File? myImage;

  Future pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      emit(LoadingAddImageToMessageList());
      myImage = imageTemporary;
      emit(SuccessAddImageToMessageList());
    } on PlatformException catch (e) {
      debugPrint('errrrrrrrrror$e');
    }
  }

  Future<void> pickImageCamera(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      // Emit loading state before starting the process
      emit(LoadingAddImageToMessageList());

      // Get the temporary file from image picker
      final imageTemporary = File(image.path);

      // Compress the image
      final compressedImage = await compressImage(imageTemporary);

      // Assign compressed image and emit success
      myImage = compressedImage;
      emit(SuccessAddImageToMessageList());
    } on PlatformException catch (e) {
      debugPrint('Error occurred while picking image: $e');
      // Optionally emit an error state or handle the error
    } catch (e) {
      debugPrint('Unexpected error: $e');
      // Handle other unexpected errors
    }
  }

  Future<File> compressImage(File file) async {
    final filePath = file.absolute.path;

    // Extract the directory and file name to construct the output path
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitFileName = filePath.substring(0, (lastIndex));
    final outPath = '${splitFileName}_compressed.jpg';

    // Compress the image
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 70, // Adjust quality here (0 - worst, 100 - best)
    );

    return File(result?.path ?? '');
  }

  SharedPreferences? sharedPreferences;
  Map<String, dynamic>? user;

  Future<void> getData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var userDetails = sharedPreferences!.getString("user");

    if (userDetails != null) {
      try {
        user = jsonDecode(userDetails);
      } catch (e) {
        print('Error decoding user details: $e');
      }
    }
  }
}
