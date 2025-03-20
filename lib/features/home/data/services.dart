import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class HomeServices {
  late Dio dio;
  HomeServices() {
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

  Future<dynamic> getSlidersAndStories() async {
    try {
      Response response = await dio.get('/api/getSliders');
      return response.data;
    } catch (e) {
      debugPrint('$e');
      return [];
    }
  }
}
