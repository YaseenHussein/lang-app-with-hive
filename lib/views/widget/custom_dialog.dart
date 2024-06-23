import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_states.dart';
import 'package:learn_lang_app/views/widget/ar_or_en_widget.dart';
import 'package:learn_lang_app/views/widget/colors_widget.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocBuilder<WriteDataCubit, WriteDataStates>(
        builder: (context, state) {
          var cubit = WriteDataCubit.get(context);
          return AnimatedContainer(
            decoration: BoxDecoration(
                color: Color(cubit.colorCode),
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            duration: const Duration(seconds: 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArabicOrEnglishWidget(
                  colorCodeSelect: cubit.colorCode,
                  isArabicSelect: cubit.isArabic,
                ),
                const SizedBox(
                  height: 15,
                ),
                ColorsWidget(activeColorCode: cubit.colorCode),
              ],
            ),
          );
        },
      ),
    );
  }
}
