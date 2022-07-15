import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_setup_event.dart';
part 'app_setup_state.dart';

class AppSetupBloc extends Bloc<AppSetupEvent, AppSetupState> {
  List<List<Color>> listColors = [
    [const Color(0xff00E0D3), const Color(0xff00B4D4)],
    [const Color(0xff00B4D4), const Color(0xff409CAE)],
    [const Color(0xff66D8A4), const Color(0xff409CAE)],
    [const Color(0xffFC727B), const Color(0xffF468A0)],
    [const Color(0xff8289EA), const Color(0xff7A6FC1)],
    [const Color(0xffFEC7A3), const Color(0xffFD9F9C)],
  ];

  AppSetupBloc() : super(AppSetupInitial()) {
    on<AppSetupEvent>((event, emit) {});
  }
}
