import 'package:flutter/material.dart';

import '../utils/constant/colors.dart';
import '../utils/constant/heading_text_style.dart';
import 'button_widgets.dart';
import 'radio_button_widgets.dart';

Future<String?> popup(
  context,
) async {
  return await showDialog(
    barrierDismissible: false,
    builder: (BuildContext context) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      return PopScope(
        canPop: false,
        child: AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Classifica con cui puoi sfidarti"),
          titlePadding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          content: ContentDialogBox(height: height, width: width),
        ),
      );
    },
    context: context,
  );
}

class ContentDialogBox extends StatefulWidget {
  const ContentDialogBox({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  State<ContentDialogBox> createState() => _ContentDialogBoxState();
}

String? val = '-1';

class _ContentDialogBoxState extends State<ContentDialogBox> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Categorie 4'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: "4.nc",
                  text: '4.nc',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '4.6',
                  text: '4.6',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '4.5',
                  text: '4.5',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '4.4',
                  text: '4.4',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '4.3',
                  text: '4.3',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '4.2',
                  text: '4.2',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          Row(
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '4.1',
                  text: '4.1',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          const Text('Categorie 3'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '3.5',
                  text: '3.5',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '3.4',
                  text: '3.4',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '3.3',
                  text: '3.3',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          Row(
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '3.2',
                  text: '3.2',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomRadioButton(
                    val: val.toString(),
                    value: '3.1',
                    text: '3.1',
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    }),
              ),
            ],
          ),
          SizedBox(
            height: widget.height * 0.01,
          ),
          const Text('Categorie 2'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '2.8',
                  text: '2.8',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '2.7',
                  text: '2.7',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '2.6',
                  text: '2.6',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '2.5',
                  text: '2.5',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '2.4',
                  text: '2.4',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '2.3',
                  text: '2.3',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          Row(
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '2.2',
                  text: '2.2',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomRadioButton(
                    val: val.toString(),
                    value: '2.1',
                    text: '2.1',
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    }),
              ),
            ],
          ),
          SizedBox(
            height: widget.height * 0.01,
          ),
          const Text('Categorie 1'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.20',
                  text: '1.20',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.19',
                  text: '1.19',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.18',
                  text: '1.18',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.17',
                  text: '1.17',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.16',
                  text: '1.16',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.15',
                  text: '1.15',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.14',
                  text: '1.14',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.13',
                  text: '1.13',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.12',
                  text: '1.12',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.11',
                  text: '1.11',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.10',
                  text: '1.10',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.9',
                  text: '1.9',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.8',
                  text: '1.8',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.7',
                  text: '1.7',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.6',
                  text: '1.6',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.5',
                  text: '1.5',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.4',
                  text: '1.4',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.3',
                  text: '1.3',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
            ],
          ),
          Row(
            children: [
              CustomRadioButton(
                  val: val.toString(),
                  value: '1.2',
                  text: '1.2',
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomRadioButton(
                    val: val.toString(),
                    value: '1.1',
                    text: '1.1',
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    }),
              ),
            ],
          ),
          SizedBox(
            height: widget.height * 0.03,
          ),
          Center(
            child: CustomButton(
                color: AppColor.buttonnewcolor,
                height: widget.height * 0.06,
                width: widget.width * 0.55,
                radius: 22,
                text: 'Close',
                style: subTitle16DarkGreyStyle.copyWith(fontSize: 22),
                onpressed: () {
                  Navigator.of(context).pop("");
                }),
          ),
          SizedBox(
            height: widget.height * 0.01,
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(val.toString());
                },
                child: Text(
                  'Save',
                  style: normal14LightGreyStyle.copyWith(
                    fontSize: 22,
                    decorationStyle: TextDecorationStyle.solid,
                    decoration: TextDecoration.underline,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
