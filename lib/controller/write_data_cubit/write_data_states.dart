abstract class WriteDataStates {}

class WriteDataInitialState extends WriteDataStates {}

class WriteDataLoadingState extends WriteDataStates {}

class WriteDataSuccessState extends WriteDataStates {}

class WriteDataFelidState extends WriteDataStates {
  final String message;

  WriteDataFelidState({required this.message});
}
