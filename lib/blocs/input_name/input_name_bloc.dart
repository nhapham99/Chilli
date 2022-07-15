import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'input_name_event.dart';
part 'input_name_state.dart';

class InputNameBloc extends Bloc<InputNameEvent, InputNameState> {
  InputNameBloc() : super(InputNameInitial()) {
    on<InputNameEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
