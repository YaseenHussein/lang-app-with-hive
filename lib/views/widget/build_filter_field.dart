
import 'package:flutter/material.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

class BuildFilterField extends StatelessWidget {
  const BuildFilterField(
      {super.key,
      required this.labels,
      required this.onTaps,
      required this.isButtonActive});
  final List<String> labels;
  final List<VoidCallback> onTaps;
  final List<bool> isButtonActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        labels.length,
        (index) => GestureDetector(
          onTap: onTaps[index],
          child: Container(
            margin: const EdgeInsetsDirectional.only(end: 10),
            height: 40,
            decoration: BoxDecoration(
                color: isButtonActive[index]
                    ? ColorManger.white
                    : ColorManger.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorManger.white, width: 1.5)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              labels[index],
              style: TextStyle(
                  fontSize: 13,
                  color: isButtonActive[index]
                      ? ColorManger.black
                      : ColorManger.white),
            ),
          ),
        ),
      ),
    );
  }
}
