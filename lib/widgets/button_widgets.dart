// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/constant/colors.dart';
import '../utils/constant/heading_text_style.dart';
import 'custom_sized_box_widget.dart';

class CustomButton extends StatelessWidget {
  String text;
  double? height;
  double width;
  TextStyle? style;
  Color? color;
  String? imgpath;
  double? radius;
  void Function()? onpressed;
  CustomButton({
    Key? key,
    required this.text,
    this.height,
   required this.width,
    this.style,
    this.color,
    this.imgpath,
    this.radius,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 17),
            color: color ?? AppColor.maincolor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: style ?? subTitle16DarkGreyStyle,
            ),
            CustomSizedBox(
              width: width! * 0.06,
            ),
            if (imgpath != null) Image.asset(imgpath!),
          ],
        ),
      ),
    );
  }
}


class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? btnColor;
  final Widget child;
  final double? radius, elevation;
  final EdgeInsetsGeometry? childPadding;
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.btnColor,
      this.elevation,
      this.radius,
      this.childPadding});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: btnColor ?? AppColor.blackcolor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 16))),
      child: Padding(
        padding: childPadding ?? EdgeInsets.zero,
        child: Container(child: child),
      ),
    );
  }
}
