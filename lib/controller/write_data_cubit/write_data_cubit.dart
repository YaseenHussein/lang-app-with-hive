import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_states.dart';
import 'package:learn_lang_app/model/word_model.dart';
import 'package:learn_lang_app/utils/hive_constants.dart';

class WriteDataCubit extends Cubit<WriteDataStates> {
  WriteDataCubit() : super(WriteDataInitialState());
  static get(context) => BlocProvider.of(context);
  final Box _box = Hive.box(HiveConstants.wordBox);
  String text = "";
  bool isArabic = true;
  int colorCode = 0xFF4A4A7A3;
  updateText(String text) {
    this.text = text;
  }

  updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
  }

  updateColorCode(int colorCode) {
    this.colorCode = colorCode;
  }

  void addWord() {
    emit(WriteDataLoadingState());
    _tryAndCatchBloc(
      methodToExcuse: () {
        List<WordModel> words = _getListOfWords();
        words.add(
          WordModel(
            text: text,
            indexAtDatabase: words.length,
            isArabic: isArabic,
            colorCode: colorCode,
          ),
        );
        _box.put(HiveConstants.wordList, words);
      },
      message: "we have problems please try later",
    );
  }

  List<WordModel> _getListOfWords() {
    return List.from(_box.get(HiveConstants.wordList, defaultValue: []))
        .cast<WordModel>();
  }

  void deleteWord({required int indexAtDatabase}) {
    _tryAndCatchBloc(
      methodToExcuse: () {
        List<WordModel> words = _getListOfWords();
        words.removeAt(indexAtDatabase);
        for (var i = indexAtDatabase; i < words.length; i++) {
          words[i] = words[i].decrementIndexAtDatabase();
        }
        _box.put(HiveConstants.wordList, words);
      },
      message: "we have problems please try later",
    );
  }

  _tryAndCatchBloc(
      {required VoidCallback methodToExcuse, required String message}) {
    emit(WriteDataLoadingState());
    try {
      methodToExcuse.call();
      emit(WriteDataSuccessState());
    } catch (error) {
      emit(WriteDataFelidState(message: message));
    }
  }

  addSimilarWord(
      {required int indexAtDatabase, required bool isArabicSimilarWord}) {
    _tryAndCatchBloc(
        methodToExcuse: () {
          List<WordModel> words = _getListOfWords();
          words[indexAtDatabase] = words[indexAtDatabase].addSimilarWord(
              similarWord: text, isArabicSimilarWord: isArabicSimilarWord);
          _box.put(HiveConstants.wordList, words);
        },
        message: "we have problems with add similar word please try later");
  }

  addExample({required int indexAtDatabase, required bool isArabicExample}) {
    _tryAndCatchBloc(
        methodToExcuse: () {
          List<WordModel> words = _getListOfWords();
          words[indexAtDatabase] = words[indexAtDatabase]
              .addExample(example: text, isArabicExample: isArabicExample);
          _box.put(HiveConstants.wordList, words);
        },
        message: "we have problems with add example word please try later");
  }

  deleteSimilarWord(
      {required int indexAtDatabase,
      required bool isArabicSimilarWord,
      required int indexAtSimilarWord}) {
    _tryAndCatchBloc(
        methodToExcuse: () {
          List<WordModel> words = _getListOfWords();
          words[indexAtDatabase] = words[indexAtDatabase].deleteSimilarWord(
              indexAtSimilarWord: indexAtSimilarWord,
              isArabicSimilarWord: isArabicSimilarWord);
          _box.put(HiveConstants.wordList, words);
        },
        message: "we have problems with delete similar word please try later");
  }

  deleteExample(
      {required int indexAtDatabase,
      required int indexAtExampleWord,
      required bool isArabicExample}) {
    _tryAndCatchBloc(
        methodToExcuse: () {
          List<WordModel> words = _getListOfWords();
          words[indexAtDatabase] = words[indexAtDatabase].deleteExample(
              indexAtExampleWord: indexAtExampleWord,
              isArabicExample: isArabicExample);
          _box.put(HiveConstants.wordList, words);
        },
        message: "we have problems with delete example word please try later");
  }
}
