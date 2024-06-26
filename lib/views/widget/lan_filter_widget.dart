import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_cubit.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_states.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

class LanFilterWidget extends StatelessWidget {
  const LanFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataStates>(
      builder: (context, state) {
        return Text(
          _getLangFilter(ReadDataCubit.get(context).languageFilter),
          style: TextStyle(
            fontSize: 20,
            color: ColorManger.white,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  String _getLangFilter(LanguageFilter languageFilter) {
    switch (languageFilter) {
      case LanguageFilter.allWord:
        return "All Word";
      case LanguageFilter.arabicOnly:
        return "Arabic";
      default:
        return "English";
    }
  }
}
