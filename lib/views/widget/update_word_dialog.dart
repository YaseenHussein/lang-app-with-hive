import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_cubit.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_states.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';
import 'package:learn_lang_app/views/widget/ar_or_en_widget.dart';
import 'package:learn_lang_app/views/widget/custom_form.dart';
import 'package:learn_lang_app/views/widget/done_button.dart';

class UpdateWordDialog extends StatefulWidget {
  const UpdateWordDialog(
      {super.key,
      required this.colorCode,
      required this.isExample,
      required this.indexAtDatabase});
  final int colorCode;
  final bool isExample;
  final int indexAtDatabase;

  @override
  State<UpdateWordDialog> createState() => _UpdateWordDialogState();
}

class _UpdateWordDialogState extends State<UpdateWordDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<WriteDataCubit, WriteDataStates>(
        listener: (context, state) {
          if (state is WriteDataSuccessState) {
            Navigator.of(context).pop();
          }
          if (state is WriteDataFelidState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorManger.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(widget.colorCode),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArabicOrEnglishWidget(
                  colorCodeSelect: widget.colorCode,
                  isArabicSelect: WriteDataCubit.get(context).isArabic,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  label: widget.isExample ? "New Example" : "New Similar Word",
                  formKey: formKey,
                ),
                const SizedBox(
                  height: 10,
                ),
                DoneButton(
                    colorCode: widget.colorCode,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (widget.isExample) {
                          WriteDataCubit.get(context).addExample(
                            indexAtDatabase: widget.indexAtDatabase,
                          );
                        } else {
                          WriteDataCubit.get(context).addSimilarWord(
                            indexAtDatabase: widget.indexAtDatabase,
                          );
                        }
                      }
                      ReadDataCubit.get(context).getWords();
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
