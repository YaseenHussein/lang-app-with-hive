import 'package:flutter/material.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_cubit.dart';
import 'package:learn_lang_app/model/word_model.dart';
import 'package:learn_lang_app/views/screen/word_details_screen.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

class WordItemWidget extends StatelessWidget {
  const WordItemWidget({super.key, required this.wordModel});
  final WordModel wordModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordDetailsScreen(
              wordModel: wordModel,
            ),
          ),
        ).then((value) {
          //هنا يحصل خطاء بسبب ان الواجهة لم تغلق بشكل كلي وحدث لنا الحالة الخاصة بنجاح
          //ولكن عند عمل هذا التوقيت يجعلنا في امان ان الشاشة تم حذفها من المكدس
          Future.delayed(const Duration(milliseconds: 500), () {
            ReadDataCubit.get(context).getWords();
          });
          
        });
      },
      child: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(wordModel.colorCode),
        ),
        child: Text(
          wordModel.text,
          style: TextStyle(
            fontSize: 18,
            color: ColorManger.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
