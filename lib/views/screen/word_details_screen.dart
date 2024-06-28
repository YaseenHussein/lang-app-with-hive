import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_cubit.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_states.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:learn_lang_app/model/word_model.dart';
import 'package:learn_lang_app/views/widget/failed_and_loading_widgte.dart';
import 'package:learn_lang_app/views/widget/update_button_widget.dart';
import 'package:learn_lang_app/views/widget/update_word_dialog.dart';
import 'package:learn_lang_app/views/widget/word_details_widget.dart';

class WordDetailsScreen extends StatefulWidget {
  const WordDetailsScreen({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  State<WordDetailsScreen> createState() => _WordDetailsScreenState();
}

class _WordDetailsScreenState extends State<WordDetailsScreen> {
  late WordModel _wordModel;
  @override
  void initState() {
    super.initState();
    _wordModel = widget.wordModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _wordDetailsAppBar(context),
      body: BlocBuilder<ReadDataCubit, ReadDataStates>(
        builder: (context, state) {
          if (state is ReadDataSuccessState) {
            // It declares a variable index of type int.
            // It uses the indexWhere method on the state.words list to find the index of an element that satisfies a certain condition.
            // The condition is defined using a lambda function or an anonymous function. It checks if the indexAtDatabase property of the current element is equal to _wordModel.indexAtDatabase.
            // The indexWhere method returns the index of the first element that satisfies the condition, or -1 if no element is found.
            // The value of index is assigned to _wordModel, effectively updating the value of _wordModel to the element found at that index in the state.words list.
//Returns -1 if [element] is not found.
            //هذا الكود يعمل على جلب الفهرس الخاص بالكائن في القائمة الجديدة
            //ن خلال عمل لوب لجميع العناصر في القائمة واذا كان الشرط صحيح سوف تعمل على اعادة الفهرس حق القائمة الجديده
            //بغض النظر عن القائمة الاصلية الموجودة في قاعدة البيانات
            // if (index != -1) {
            //   _wordModel = state.words[index];
            // }
            int index = state.words.indexWhere(
              (element) =>
                  element.indexAtDatabase == _wordModel.indexAtDatabase,
            );

            _wordModel = state.words[index];
            //this code will give us error when we delete all data in database and
            //we us the indexWhere method to get index

            return _wordDetailsBody(context);
          } else if (state is ReadDataFailedState) {
            return getFailedWidget(state.message);
          } else {
            return getLoadingWidget(context);
          }
        },
      ),
    );
  }

  ListView _wordDetailsBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        _getLabel("Word"),
        const SizedBox(
          height: 10,
        ),
        WordDetailsWidget(
          color: _wordModel.colorCode,
          word: _wordModel.text,
          isArabic: widget.wordModel.isArabic,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            _getLabel("Similar Word"),
            const Spacer(),
            UpdateButtonWidget(
              color: _wordModel.colorCode,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => UpdateWordDialog(
                    indexAtDatabase: _wordModel.indexAtDatabase,
                    colorCode: _wordModel.colorCode,
                    isExample: false,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        for (int i = 0; i < _wordModel.englishSimilarWords.length; i++) ...[
          WordDetailsWidget(
            color: _wordModel.colorCode,
            word: _wordModel.englishSimilarWords[i],
            deleteOnTap: () => _deleteEnglishSimilarWords(i),
            isArabic: false,
          ),
          const SizedBox(
            height: 10,
          )
        ],
        for (int i = 0; i < _wordModel.arabicSimilarWords.length; i++) ...[
          WordDetailsWidget(
            deleteOnTap: () => _deleteArabicSimilarWords(i),
            color: _wordModel.colorCode,
            word: _wordModel.arabicSimilarWords[i],
            isArabic: true,
          ),
          const SizedBox(
            height: 10,
          )
        ],
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            _getLabel("Example Word"),
            const Spacer(),
            UpdateButtonWidget(
              color: _wordModel.colorCode,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => UpdateWordDialog(
                    indexAtDatabase: _wordModel.indexAtDatabase,
                    colorCode: _wordModel.colorCode,
                    isExample: true,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        for (int i = 0; i < _wordModel.englishExamples.length; i++) ...[
          WordDetailsWidget(
            deleteOnTap: () => _deleteEnglishExamples(i),
            color: _wordModel.colorCode,
            word: _wordModel.englishExamples[i],
            isArabic: false,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
        for (int i = 0; i < _wordModel.arabicExamples.length; i++) ...[
          WordDetailsWidget(
            deleteOnTap: () => _deleteArabicExamples(i),
            color: _wordModel.colorCode,
            word: _wordModel.arabicExamples[i],
            isArabic: true,
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ],
    );
  }

  _deleteArabicExamples(int index) {
    WriteDataCubit.get(context).deleteExample(
        indexAtDatabase: _wordModel.indexAtDatabase,
        indexAtExampleWord: index,
        isArabicExample: true);
    ReadDataCubit.get(context).getWords();
  }

  _deleteEnglishExamples(int index) {
    WriteDataCubit.get(context).deleteExample(
        indexAtDatabase: _wordModel.indexAtDatabase,
        indexAtExampleWord: index,
        isArabicExample: false);
    ReadDataCubit.get(context).getWords();
  }

  _deleteArabicSimilarWords(int index) {
    WriteDataCubit.get(context).deleteSimilarWord(
        indexAtDatabase: _wordModel.indexAtDatabase,
        isArabicSimilarWord: true,
        indexAtSimilarWord: index);
    ReadDataCubit.get(context).getWords();
  }

  _deleteEnglishSimilarWords(int index) {
    WriteDataCubit.get(context).deleteSimilarWord(
        indexAtDatabase: _wordModel.indexAtDatabase,
        isArabicSimilarWord: false,
        indexAtSimilarWord: index);
    ReadDataCubit.get(context).getWords();
  }

  Text _getLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Color(_wordModel.colorCode),
        fontSize: 25,
        fontWeight: FontWeight.bold,
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
      foregroundColor: Color(_wordModel.colorCode),
      title: Text(
        _wordModel.text,
        style: TextStyle(color: Color(_wordModel.colorCode), fontSize: 25),
      ),
    );
  }

  _deleteWord(BuildContext context) {
    WriteDataCubit.get(context)
        .deleteWord(indexAtDatabase: _wordModel.indexAtDatabase);
    Navigator.of(context).pop();
  }
}
