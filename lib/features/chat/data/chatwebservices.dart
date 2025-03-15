import 'dart:io';
import 'package:academy_lms_app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatWebServices {
  late Dio dio;
  ChatWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final authToken = prefs.getString('access_token') ?? '';
        options.headers['Authorization'] = 'Bearer $authToken';
        return handler.next(options);
      },
    ));
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Future<dynamic> messagesList(String roomId) async {
    try {
      Response response = await dio.get(
        '/api/messages/$roomId',
      );

      return response.data;
    } catch (e) {
      debugPrint('$e');
      return [];
    }
  }

  Future<dynamic> messageRegister(
      {required String receiverId,
      required File? chatImage,
      required String? content}) async {
    try {
      FormData formData =
          FormData.fromMap({"message": content, "receiver_id": receiverId});
      // if (chatImage != null && content == null) {
      //   String fileName = chatImage.path.split('/').last;
      //   var data =
      //       await MultipartFile.fromFile(chatImage.path, filename: fileName);
      //   formData = FormData.fromMap({'media': data});
      // } else if (chatImage != null) {
      //   String fileName = chatImage.path.split('/').last;
      //   var data =
      //       await MultipartFile.fromFile(chatImage.path, filename: fileName);
      //   formData = FormData.fromMap({
      //     'content': content,
      //     'media': data,
      //   });
      // } else {
      //   formData = FormData.fromMap({
      //     'content': content,
      //   });
      // }
      // ;

      Response response = await dio.post(
        '/api/message-store',
        data: formData,
      );
      return response.data;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getRoomList() async {
    try {
      Response response = await dio.get(
        '/api/get-admins',
      );
      return response.data;
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> getMessagesRoomList() async {
    try {
      Response response = await dio.get(
        '/api/message-search',
      );
      return response.data;
    } catch (e) {
      return {};
    }
  }

  Future<dynamic> getMyUserData() async {
    try {
      Response response = await dio.get(
        '/api/getUser',
      );
      return response.data;
    } catch (e) {
      return {};
    }
  }
}
