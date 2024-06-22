import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_states.dart';
import 'package:learn_lang_app/utils/hive_constants.dart';

class ReadDataCubit extends Cubit<ReadDataStates> {
  ReadDataCubit() : super(ReadDataInitialState());
  static get(context) => BlocProvider.of(context);

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
