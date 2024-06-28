
import 'package:flutter/material.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

class UpdateButtonWidget extends StatelessWidget {
  const UpdateButtonWidget({
    super.key,
    required this.color,
    required this.onTap,
  });

  final int color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.center,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        width: 80,
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.add,
          size: 30,
          color: ColorManger.black,
        ),
      ),
    );
  }
}
