import 'package:flutter/material.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';
import 'package:learn_lang_app/views/widget/Lan_filter_widget.dart';

import 'package:learn_lang_app/views/widget/add_word_dialog.dart';

class HoneScreen extends StatelessWidget {
  const HoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManger.white,
        onPressed: () => showDialog(
            builder: (context) => const AddWordDialog(), context: context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [LanFilterWidget()],
            )
          ],
        ),
      ),
    );
  }
}
