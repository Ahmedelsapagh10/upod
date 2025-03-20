import 'dart:developer';

import 'package:academy_lms_app/features/home/data/services.dart';

import 'model/story_and_slider_model.dart';

class HomeRepo {
  HomeServices api;
  HomeRepo(this.api);

  Future<MainStoryAndSliderModel> getSlidersAndStories() async {
    final res = await api.getSlidersAndStories();
    log('Response: $res', name: 'HomeRepo');
    return MainStoryAndSliderModel.fromJson(res);
  }
}
