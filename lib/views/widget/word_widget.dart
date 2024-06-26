import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_cubit.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_states.dart';
import 'package:learn_lang_app/model/word_model.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';
import 'package:learn_lang_app/views/widget/word_item_widget.dart';

class WordWidget extends StatelessWidget {
  const WordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataStates>(
      builder: (context, state) {
        if (state is ReadDataSuccessState) {
          if (state.words.isEmpty) {
            return _getEmptyWordsWidget(context);
          }
          return _getWordsWidget(state.words);
        } else if (state is ReadDataFailedState) {
          return _getFailedWidget(state.message);
        } else {
          return _getLoadingWidget(context);
        }
      },
    );
  }

  Widget _getWordsWidget(List<WordModel> listWordModel) {
    return GridView.builder(
      itemCount: listWordModel.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2 / 1.5),
      itemBuilder: (context, index) => WordItemWidget(
        wordModel: listWordModel[index],
      ),
    );
  }

  Widget _getEmptyWordsWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            FittedBox(
              child: Icon(
                Icons.menu,
                color: ColorManger.white.withOpacity(.5),
                size: 300,
              ),
            ),
            Text(
              "there are not word please add word?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorManger.white.withOpacity(.5),
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getFailedWidget(String message) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Icon(
              Icons.error,
              color: ColorManger.white.withOpacity(.5),
              size: 200,
            ),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorManger.white.withOpacity(.5),
              fontSize: 25,
            ),
          )
        ],
      ),
    );
  }

  Widget _getLoadingWidget(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorManger.white,
      ),
    );
  }
}
