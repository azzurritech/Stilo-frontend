// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/widgets/button_widgets.dart';

import '../utils/constant/colors.dart';
import '../utils/constant/heading_text_style.dart';

class CustomListTileButton extends StatelessWidget {
  String text;

  double? height;
  double? width;

  TextStyle? style;
  Color? color;
  void Function()? ontap;
  CustomListTileButton({
    Key? key,
    required this.text,
    this.color,
    this.height,
    this.style,
    this.width,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      height: height ?? MediaQuery.of(context).size.height,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: color ?? AppColor.divivdercolor,
        ),
        onPressed: ontap,
        child: Center(
          child: Text(
            text,
            style: style ?? subTitle16DarkGreyStyle,
          ),
        ),
        // leading: icon,
        // trailing: trailing,
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String? titleText, subTitleText;
  final Widget? leadingWidget, trailingWidget;
  const CustomListTile(
      {super.key,
      this.titleText,
      this.subTitleText,
      this.leadingWidget,
      this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        titleText.toString(),
        style: normal14BlackStyle,
      ),
      subtitle: Text(
        subTitleText.toString(),
        style: normal14LightGreyStyle,
      ),
      leading: leadingWidget,
      trailing: trailingWidget,
    );
  }
}
