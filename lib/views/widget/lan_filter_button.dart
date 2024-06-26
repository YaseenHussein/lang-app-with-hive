import 'package:flutter/material.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';
import 'package:learn_lang_app/views/widget/filter_dialog_widget.dart';

class LanFilterButton extends StatelessWidget {
  const LanFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const FilterDialogWidget(),
        );
      },
      child: CircleAvatar(
        radius: 22,
        backgroundColor: ColorManger.white,
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
