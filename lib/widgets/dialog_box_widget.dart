import 'package:flutter/material.dart';

import '../utils/constant/colors.dart';
import '../utils/constant/heading_text_style.dart';

customDialogBox(
  context, {
  String? title,
  String? content,
  onCancel,
  onOk,
}) {
  return AlertDialog(
    insetPadding: const EdgeInsets.all(20),
    elevation: 70,
    titlePadding: const EdgeInsets.only(top: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    contentPadding:
        const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 25),
    actionsPadding:
        const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
    // buttonPadding: const EdgeInsets.only(left: 12),
    title: Center(
      child: Text(
        title ?? 'Warning!',
        // style: kHeading20BlackStyle.copyWith(fontSize: 22),
      ),
    ),

    content: Text(
      content ?? 'Your data will be lost if you press OK ',
      textAlign: TextAlign.center,
      // style: kSubHeading17GreyTextStyle.copyWith(
      //     color: kDarkDisableColor, fontSize: 16),
    ),
    backgroundColor: AppColor.searchcolor,
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
                    height: 40,
                    // width: 125,
                    child: ButtonWidget(
                        btnColor: AppColor.buttonGreencolor,
                        style: normal14BlackStyle.copyWith(
                            color: AppColor.textcolor),
                        // borderRadius: BorderRadius.circular(6),
                        onPressed: onCancel,
                        text: 'Cancel'))),
            const SizedBox(width: 10),
            Expanded(
                child: SizedBox(
                    height: 40,
                    // width: 125,
                    child: ButtonWidget(
                      style: normal14BlackStyle.copyWith(
                          color: AppColor.textcolor),
                      btnColor: AppColor.refusecolor,
                      text: 'Ok',
                      onPressed: onOk,
                    )))
          ],
        ),
      ),
    ],
  );
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.onPressed,
    this.btnColor,
    this.style,
    this.circularRadius,
    required this.text,
  }) : super(key: key);
  final Function() onPressed;
  final Color? btnColor;
  final TextStyle? style;
  final String text;
  final double? circularRadius;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: btnColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularRadius??0))),
        // size: const Size(double.infinity, 32),
        // borderRadius: BorderRadius.circular(6),
        onPressed: onPressed,
        // color: kLightBlueColor,
        child: Text(text, style: style
            // style: .copyWith(
            //     fontSize: 16)
            ));
  }
}
