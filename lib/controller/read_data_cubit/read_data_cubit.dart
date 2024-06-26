import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_states.dart';
import 'package:learn_lang_app/model/word_model.dart';
import 'package:learn_lang_app/utils/hive_constants.dart';

class ReadDataCubit extends Cubit<ReadDataStates> {
  ReadDataCubit() : super(ReadDataInitialState());
  static ReadDataCubit get(context) => BlocProvider.of(context);

  final Box _box = Hive.box(HiveConstants.wordBox);
  LanguageFilter languageFilter = LanguageFilter.allWord;
  SortedBy sortedBy = SortedBy.time;
  SortingType sortingType = SortingType.descending;
  updateLanguageFilter({required LanguageFilter languageFilter}) {
    this.languageFilter = languageFilter;
    getWords();
  }

  updateSortedBy({required SortedBy sortedBy}) {
    this.sortedBy = sortedBy;
    getWords();
  }

  updateSortingType({required SortingType sortingType}) {
    this.sortingType = sortingType;
    getWords();
  }

  getWords() {
    emit(ReadDataLoadingState());
    try {
      List<WordModel> wordsToReturn =
          List.from(_box.get(HiveConstants.wordList, defaultValue: []))
              .cast<WordModel>();

      _removeUnWantWords(wordsToReturn);
      _applySorting(wordsToReturn);
      emit(ReadDataSuccessState(words: wordsToReturn));
    } catch (error) {
      emit(ReadDataFailedState(
          message: "there are problems please try later again"));
    }
  }

  _removeUnWantWords(List<WordModel> wordsToReturn) {
    if (languageFilter == LanguageFilter.allWord) {
      return;
    }
    for (var i = 0; i < wordsToReturn.length; i++) {
      if ((languageFilter == LanguageFilter.arabicOnly &&
              wordsToReturn[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishOnly &&
              wordsToReturn[i].isArabic == true)) {
        wordsToReturn.removeAt(i);
        i--;
      }
    }
  }

  _applySorting(List<WordModel> wordsToReturn) {
    if (sortedBy == SortedBy.time) {
      if (sortingType == SortingType.ascending) {
        return;
      } else {
        _reverse(wordsToReturn);
      }
    } else {
//It sorts a list of WordModel objects called wordsToReturn based on the length of the text property of each object.

//The sort method is called on the wordsToReturn list and it takes a comparison function as an argument. This comparison function compares two WordModel objects (a and b) based on the length of their text property.

//The compareTo method is used to compare the lengths of the text properties. It returns a negative value if a.text.length is less than b.text.length, a positive value if a.text.length is greater than b.text.length, and 0 if they are equal.

//After the sort method is called, the wordsToReturn list will be sorted in ascending order based on the length of the text property of each WordModel object.
      wordsToReturn.sort(
        (WordModel a, WordModel b) => a.text.length.compareTo(b.text.length),
      );
      if (sortingType == SortingType.ascending) {
        return;
      } else {
        _reverse(wordsToReturn);
      }
    }
  }

  void _reverse(List<WordModel> wordsToReturn) {
    for (var i = 0; i < wordsToReturn.length / 2; i++) {
      WordModel temp = wordsToReturn[i];
      wordsToReturn[i] = wordsToReturn[wordsToReturn.length - 1 - i];
      wordsToReturn[wordsToReturn.length - 1 - i] = temp;
    }
  }
}

enum LanguageFilter {
  arabicOnly,
  englishOnly,
  allWord,
}

enum SortedBy {
  time,
  wordLength,
}

enum SortingType {
  ascending,
  descending,
}
