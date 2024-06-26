import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_cubit.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_states.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';
import 'package:learn_lang_app/views/widget/Lan_filter_widget.dart';

import 'package:learn_lang_app/views/widget/add_word_dialog.dart';
import 'package:learn_lang_app/views/widget/lan_filter_button.dart';
import 'package:learn_lang_app/views/widget/word_widget.dart';

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
              children: [
                LanFilterWidget(),
                Spacer(),
                LanFilterButton(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: WordWidget())
          ],
        ),
      ),
    );
  }
}
