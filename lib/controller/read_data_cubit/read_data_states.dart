import 'package:learn_lang_app/model/word_model.dart';

abstract class ReadDataStates {}

class ReadDataInitialState extends ReadDataStates {}

class ReadDataLoadingState extends ReadDataStates {}

class ReadDataSuccessState extends ReadDataStates {
  final List<WordModel> words;

  ReadDataSuccessState({required this.words});
}

class ReadDataFailedState extends ReadDataStates {
  final String message;

  ReadDataFailedState({required this.message});
}
