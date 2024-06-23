import 'package:flutter/material.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({super.key, required this.activeColorCode});
  final int activeColorCode;
  final List<int> colorsCodes = const [
    0xFFFFB833,
    0xFFCEFF33,
    0xFF1FF1DB,
    0xFF12A8EE,
    0xFF507DEC,
    0xFFDA3CFD,
    0xFFE21A93,
    0xFFAB114D,
    0xFF6C83B4,
    0xFFFB5757,
    0xFF8B4805,
    0xFF0B6E93,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                WriteDataCubit.get(context).updateColorCode(colorsCodes[index]);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: activeColorCode == colorsCodes[index]
                      ? Border.all(width: 2, color: ColorManger.white)
                      : null,
                  shape: BoxShape.circle,
                  color: Color(colorsCodes[index]),
                ),
                child: activeColorCode == colorsCodes[index]
                    ? Icon(
                        Icons.done,
                        color: ColorManger.white,
                        size: 30,
                      )
                    : null,
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 7,
              ),
          itemCount: colorsCodes.length),
    );
  }
}
