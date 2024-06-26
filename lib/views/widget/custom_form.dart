import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, required this.label, required this.fromKey});
  final String label;
  final GlobalKey<FormState> fromKey;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.fromKey,
        child: TextFormField(
          autofocus: true,
          controller: controller,
          cursorColor: ColorManger.white,
          maxLines: 5,
          minLines: 1,
          style: TextStyle(color: ColorManger.white),
          onChanged: (value) {
            WriteDataCubit.get(context).updateText(value);
          },
          validator: (value) {
            return _validatorMethod(
                value, WriteDataCubit.get(context).isArabic);
          },
          decoration: InputDecoration(
              focusedErrorBorder: _myErrorDefaultBorder(),
              errorBorder: _myErrorDefaultBorder(),
              enabledBorder: _myDefaultBorder(),
              focusedBorder: _myDefaultBorder(),
              label: Text(
                widget.label,
                style: TextStyle(color: ColorManger.white),
              ),
              border: _myDefaultBorder()),
        ));
  }

  String? _validatorMethod(String? value, bool isArabic) {
    if (value == null || value.trim().isEmpty) {
      return "your input is empty for that should \n this input to be not empty";
    }
    for (var i = 0; i < value.length; i++) {
      CharType charType = _getCharType(value.codeUnitAt(i));
      if (charType == CharType.notValid) {
        return "in char ${i + 1} is not char please enter true char";
      } else if (charType == CharType.arabic && isArabic == false) {
        return "in char ${i + 1} is not English char";
      } else if (charType == CharType.english && isArabic == true) {
        return "in char ${i + 1} is not arabic char";
      }
    }
    return null;
  }

  OutlineInputBorder _myDefaultBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: ColorManger.white, width: 2),
      );

  OutlineInputBorder _myErrorDefaultBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: ColorManger.white, width: 2),
      );

  CharType _getCharType(int codeUnitAt) {
    if ((codeUnitAt >= 65 && codeUnitAt <= 90) ||
        (codeUnitAt >= 90 && codeUnitAt <= 122)) {
      return CharType.english;
    } else if (codeUnitAt >= 1575 && codeUnitAt <= 1610) {
      return CharType.arabic;
    } else if (32 == codeUnitAt) {
      return CharType.space;
    } else {
      return CharType.notValid;
    }
  }
}

enum CharType {
  english,
  arabic,
  space,
  notValid,
}
