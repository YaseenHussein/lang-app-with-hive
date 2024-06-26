import 'package:flutter/material.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

class WordDetailsWidget extends StatelessWidget {
  const WordDetailsWidget(
      {super.key,
      required this.color,
      required this.word,
      required this.isArabic,
      this.deleteOnTap});
  final int color;
  final String word;
  final bool isArabic;
  final VoidCallback? deleteOnTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorManger.black,
            radius: 25,
            child: Text(
              isArabic ? "ar" : "en",
              style:
                  TextStyle(color: Color(color), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              word,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: ColorManger.white),
            ),
          ),
          if (deleteOnTap != null) ...[
            IconButton(
              onPressed: deleteOnTap,
              icon: Icon(
                Icons.delete,
                size: 30,
                color: ColorManger.black,
              ),
            )
          ]
        ],
      ),
    );
  }
}
