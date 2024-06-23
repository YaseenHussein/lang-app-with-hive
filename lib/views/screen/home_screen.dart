import 'package:flutter/material.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

import 'package:learn_lang_app/views/widget/custom_dialog.dart';

class HoneScreen extends StatelessWidget {
  const HoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManger.white,
        onPressed: () => showDialog(
            builder: (context) => const CustomDialog(), context: context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
