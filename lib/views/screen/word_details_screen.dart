import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:learn_lang_app/model/word_model.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';
import 'package:learn_lang_app/views/widget/word_details_widget.dart';

class WordDetailsScreen extends StatelessWidget {
  const WordDetailsScreen({super.key, required this.wordModel});
  final WordModel wordModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _wordDetailsAppBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Text(
            "Word",
            style: TextStyle(
              color: ColorManger.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          WordDetailsWidget(
            color: wordModel.colorCode,
            word: wordModel.text,
            isArabic: wordModel.isArabic,
          ),
        ],
      ),
    );
  }

  AppBar _wordDetailsAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () => _deleteWord(context),
            icon: const Icon(Icons.delete))
      ],
      foregroundColor: Color(wordModel.colorCode),
      title: Text(
        wordModel.text,
        style: TextStyle(color: Color(wordModel.colorCode), fontSize: 25),
      ),
    );
  }

  void _deleteWord(BuildContext context) {
    WriteDataCubit.get(context)
        .deleteWord(indexAtDatabase: wordModel.indexAtDatabase);
    Navigator.of(context).pop();
  }
}
