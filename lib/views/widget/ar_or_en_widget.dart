import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

class ArabicOrEnglishWidget extends StatelessWidget {
  const ArabicOrEnglishWidget({
    super.key,
    required this.colorCodeSelect,
    required this.isArabicSelect,
  });
  final int colorCodeSelect;
  final bool isArabicSelect;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getContainer(context,buildingArabic: true),
        const SizedBox(
          width: 10,
        ),
        _getContainer(context,buildingArabic: false)
      ],
    );
  }

  Widget _getContainer(BuildContext context,{required bool buildingArabic}) {
    return InkWell(
      onTap: () {
        WriteDataCubit.get(context).updateIsArabic(buildingArabic);
      },
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManger.white, width: 2),
          color: buildingArabic == isArabicSelect
              ? ColorManger.white
              : Color(colorCodeSelect),
          shape: BoxShape.circle,
        ),
        child: Text(
          buildingArabic ? "ar" : "en",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: buildingArabic == isArabicSelect
                  ? Color(colorCodeSelect)
                  : ColorManger.white),
        ),
      ),
    );
  }
}
