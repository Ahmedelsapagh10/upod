import 'package:academy_lms_app/features/home/data/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/common_functions.dart';
import '../data/model/story_and_slider_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeInitial());
  HomeRepo api;

  MainStoryAndSliderModel? mainStoryAndSliderModel;

  getSlidersAndStories(BuildContext context) async {
    emit(LoadingGetSliderAndStories());
    api.getSlidersAndStories().then((e) {
      mainStoryAndSliderModel = e;
      print('&&&&&&&&&&${mainStoryAndSliderModel!.stories!.length}');
      emit(LoadedGetSliderAndStories());
    }).onError((error, stackTrace) {
      print('Error &&&&&&&&&&${mainStoryAndSliderModel?.stories?.length}');

      emit(ErrorGetSliderAndStories());
    });
  }
}
