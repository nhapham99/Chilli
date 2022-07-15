part of 'app_setup_bloc.dart';

abstract class AppSetupState extends Equatable {
  const AppSetupState();
  
  @override
  List<Object> get props => [];
}

class AppSetupInitial extends AppSetupState {}
