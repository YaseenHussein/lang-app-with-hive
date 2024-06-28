import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_cubit.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_states.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';
import 'package:learn_lang_app/views/widget/ar_or_en_widget.dart';
import 'package:learn_lang_app/views/widget/colors_widget.dart';
import 'package:learn_lang_app/views/widget/custom_form.dart';
import 'package:learn_lang_app/views/widget/done_button.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({
    super.key,
  });

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState> newWordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<WriteDataCubit, WriteDataStates>(
        listener: (context, state) {
          if (state is WriteDataSuccessState) {
            Navigator.pop(context);
          }
          if (state is WriteDataFelidState) {
            _showScaffoldMessenger(context, state);
          }
        },
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
                const SizedBox(
                  height: 15,
                ),
                CustomForm(label: "new Word", formKey: newWordKey),
                const SizedBox(
                  height: 15,
                ),
                DoneButton(
                    colorCode: cubit.colorCode,
                    onTap: () {
                      if (newWordKey.currentState!.validate()) {
                        cubit.addWord();
                        ReadDataCubit.get(context).getWords();
                      }
                    })
              ],
            ),
          );
        },
      ),
    );
  }

  void _showScaffoldMessenger(BuildContext context, WriteDataFelidState state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
        backgroundColor: ColorManger.red,
      ),
    );
  }
}
