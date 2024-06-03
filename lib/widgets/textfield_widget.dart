// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/constant/button_text_style.dart';
import '../utils/constant/colors.dart';

class TextFields extends StatelessWidget {
  String text;
  double? height;
  double? width;
  Widget? suffixicon;
  TextStyle? textStyle;
  TextAlign? textAligns;
  TextEditingController? controller;
  bool? obsecureText;
  int? minLines, maxLines;
  bool? readOnly;
  Function(String?)? onChanged;
  String? Function(String?)? validator;
  Function()? onTap;
  Function(String)? onSubmitted;
  TextFields(
      {Key? key,
      required this.text,
      this.height,
      this.width,
      this.textStyle,
      this.suffixicon,
      this.textAligns,
      this.controller,
      this.obsecureText,
      this.onChanged,
      this.onTap,
      this.readOnly,
      this.onSubmitted,
      this.maxLines,
      this.minLines,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxLines != null
          ? null
          : height ?? MediaQuery.of(context).size.height * 0.055,
      child: TextFormField(
        // autofillHints: [AutofillHints.email],
        minLines: minLines,
        maxLines: maxLines ?? 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        onTap: onTap,
        controller: controller,
        obscureText: obsecureText ?? false,
        style: textStyle,
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        validator: validator,
        textAlign: textAligns ?? TextAlign.start,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, top: 20),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
            filled: true,
            fillColor: AppColor.textfield_color,
            suffixIcon: suffixicon,
            errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.refusecolor)),
            focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.refusecolor)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            hintText: text,
            hintStyle: hint_text),
      ),
    );
  }
}
