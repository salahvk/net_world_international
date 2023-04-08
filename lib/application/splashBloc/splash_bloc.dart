import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(Initial()) {
    on<NavigateToHomeScreenEvent>((event, emit) async {
      try {
        emit(Loading());

        // Either<MainFailure, LanguageModel> result =
        //     await LandingImpl().getLanguageData();

        // LanguageModel languageModel = result.fold(
        //   (failure) {
        //     // handle the failure case here
        //     return LanguageModel(); // or some default value
        //   },
        //   (model) => model,
        // );
        // await LandingImpl().getCountriesData();
        await Future.delayed(const Duration(seconds: 3));
        emit(Loaded());
      } catch (_) {}
    });

    on((event, emit) {});
  }
}
