  import 'package:flutter/material.dart';


import '../utils/constant/button_text_style.dart';
import '../utils/constant/colors.dart';

checkListTile(
      {required String titleText,
      required bool checkValue,
     
      required Function(bool?)? onChanged}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.maincolor, width: 1.2)),
      child: CheckboxListTile(
        value: checkValue,
        onChanged: onChanged,
        title: Text(
          titleText,
          style: hint_text,
        ),
      ),
    );
  }