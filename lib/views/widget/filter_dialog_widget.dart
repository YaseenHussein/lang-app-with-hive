
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_cubit.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_states.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';
import 'package:learn_lang_app/views/widget/build_filter_field.dart';

class FilterDialogWidget extends StatelessWidget {
  const FilterDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataStates>(
      builder: (context, state) {
        var cubit = ReadDataCubit.get(context);
        return Dialog(
          backgroundColor: ColorManger.black,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _defaultLabelText("Language"),
                const SizedBox(
                  height: 10,
                ),
                BuildFilterField(
                  labels: const ["Arabic", "English", "All"],
                  onTaps: [
                    () => cubit.updateLanguageFilter(
                        languageFilter: LanguageFilter.arabicOnly),
                    () => cubit.updateLanguageFilter(
                        languageFilter: LanguageFilter.englishOnly),
                    () => cubit.updateLanguageFilter(
                        languageFilter: LanguageFilter.allWord),
                  ],
                  isButtonActive: [
                    cubit.languageFilter == LanguageFilter.arabicOnly,
                    cubit.languageFilter == LanguageFilter.englishOnly,
                    cubit.languageFilter == LanguageFilter.allWord,
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                _defaultLabelText("Sorted By"),
                const SizedBox(
                  height: 10,
                ),
                BuildFilterField(
                  labels: const [
                    "Time",
                    "word length",
                  ],
                  onTaps: [
                    () => cubit.updateSortedBy(sortedBy: SortedBy.time),
                    () => cubit.updateSortedBy(sortedBy: SortedBy.wordLength)
                  ],
                  isButtonActive: [
                    cubit.sortedBy == SortedBy.time,
                    cubit.sortedBy == SortedBy.wordLength,
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                _defaultLabelText("Sorting Type"),
                const SizedBox(
                  height: 10,
                ),
                BuildFilterField(
                  labels: const [
                    "Ascending",
                    "Descending",
                  ],
                  onTaps: [
                    () => cubit.updateSortingType(
                        sortingType: SortingType.ascending),
                    () => cubit.updateSortingType(
                        sortingType: SortingType.descending),
                  ],
                  isButtonActive: [
                    cubit.sortingType == SortingType.ascending,
                    cubit.sortingType == SortingType.descending,
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Text _defaultLabelText(String label) {
    return Text(
      label,
      style: TextStyle(
          fontSize: 18, color: ColorManger.white, fontWeight: FontWeight.bold),
    );
  }
}
