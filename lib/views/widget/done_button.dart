import 'package:flutter/material.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key, required this.colorCode, required this.onTap});
  final int colorCode;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          alignment: Alignment.center,
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: ColorManger.white,
            borderRadius: BorderRadiusDirectional.circular(12),
          ),
          child: Text(
            "Done",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(colorCode),
            ),
          ),
        ),
      ),
    );
  }
}
