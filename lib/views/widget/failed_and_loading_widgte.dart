  import 'package:flutter/material.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

Widget getFailedWidget(String message) {
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

  Widget getLoadingWidget(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorManger.white,
      ),
    );
  }