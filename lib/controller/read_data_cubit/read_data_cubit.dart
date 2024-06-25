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
  }

  updateSortedBy({required SortedBy sortedBy}) {
    this.sortedBy = sortedBy;
  }

  updateSortingType({required SortingType sortingType}) {
    this.sortingType = sortingType;
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
      emit(ReadDataFelidState(
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
