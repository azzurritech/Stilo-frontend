// import 'package:flutter/material.dart';

// import '../utilities/constant/colors.dart';
// import '../utilities/constant/heading_text_style.dart';
// import '../utilities/constant/image_path.dart';
// import '../widgets/app_bar_widget.dart';
// import '../widgets/button_widgets.dart';
// import '../widgets/circle_widget.dart';
// import '../widgets/radio_button_widgets.dart';
// import '../widgets/textfield_widget.dart';
// import 'lesson_finite.dart';

// class Matchfinito extends StatefulWidget {
//   const Matchfinito({super.key});

//   @override
//   State<Matchfinito> createState() => _MatchfinitoState();
// }

// class _MatchfinitoState extends State<Matchfinito> {
//   DateTime today = DateTime.now();
//   String val = "1";
//   String vals = "1";
//   String valss = "1";
//   String valsss = "1";
//   String vc = "1";
//   String vcs = "1";
//   String vcss = "1";
//   String vcsa = "1";
//   String vcsb = "1";
//   String valq = "1";
//   String valqq = "1";
//   String za = "1";
//   String zaa = "1";
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBarWidget(
//         title: 'Challenge',
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 27.0, horizontal: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       children: [
//                         CustomCircleAvatar(
//                             radius: 50, images: ImagePath.loginlogo),
//                         Text(
//                           'You',
//                           style: title18BlackStyle,
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           "Vs",
//                           style: vscolor,
//                         ),
//                         Image.asset(ImagePath.lessonball)
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         CustomCircleAvatar(
//                             radius: 50, images: ImagePath.loginlogo),
//                         Text(
//                           "Novak",
//                           style: title18BlackStyle,
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Divider(
//                   thickness: 2,
//                   color: AppColor.maincolor,
//                   height: 5,
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Date: 24.12.2022 ",
//                         style: subTitle16BlackStyle,
//                       ),
//                       Text(
//                         "Time:  20:00",
//                         style: subTitle16BlackStyle,
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: height * 0.04,
//                 ),
//                 Container(
//                   child: Row(
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 26.0),
//                           child: Column(
//                             children: [
//                               Text(
//                                 "You",
//                                 style: title18BlackStyle,
//                               ),
//                               SizedBox(
//                                 height: height * 0.03,
//                               ),
//                               Text(
//                                 "Nadal",
//                                 style: title18BlackStyle,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Spacer(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Table(
//                               defaultColumnWidth: FixedColumnWidth(80.0),
//                               children: [
//                                 TableRow(children: [
//                                   Column(children: [
//                                     Text('Sets', style: subTitle16BlackStyle),
//                                     SizedBox(
//                                       height: height * 0.01,
//                                     ),
//                                     TextFields(
//                                         textStyle: TextStyle(
//                                             color: AppColor.hinttext_color),
//                                         textAligns: TextAlign.center,
//                                         width: width * 0.1,
//                                         height: height * 0.04,
//                                         text: ''),
//                                     SizedBox(
//                                       height: height * 0.02,
//                                     ),
//                                     TextFields(
//                                         textStyle: TextStyle(
//                                             color: AppColor.hinttext_color),
//                                         textAligns: TextAlign.center,
//                                         width: width * 0.1,
//                                         height: height * 0.04,
//                                         text: '')
//                                   ]),
//                                   Column(children: [
//                                     Text('Games', style: subTitle16BlackStyle),
//                                     SizedBox(
//                                       height: height * 0.01,
//                                     ),
//                                     TextFields(
//                                         textStyle: TextStyle(
//                                             color: AppColor.hinttext_color),
//                                         textAligns: TextAlign.center,
//                                         width: width * 0.1,
//                                         height: height * 0.04,
//                                         text: ''),
//                                     SizedBox(
//                                       height: height * 0.02,
//                                     ),
//                                     TextFields(
//                                         textStyle: TextStyle(
//                                             color: AppColor.hinttext_color),
//                                         textAligns: TextAlign.center,
//                                         width: width * 0.1,
//                                         height: height * 0.04,
//                                         text: '')
//                                   ]),
//                                   Column(children: [
//                                     Text('Points', style: subTitle16BlackStyle),
//                                     SizedBox(
//                                       height: height * 0.01,
//                                     ),
//                                     TextFields(
//                                         textStyle: TextStyle(
//                                             color: AppColor.hinttext_color),
//                                         textAligns: TextAlign.center,
//                                         width: width * 0.1,
//                                         height: height * 0.04,
//                                         text: ''),
//                                     SizedBox(
//                                       height: height * 0.02,
//                                     ),
//                                     TextFields(
//                                         textStyle: TextStyle(
//                                             color: AppColor.hinttext_color),
//                                         textAligns: TextAlign.center,
//                                         width: width * 0.1,
//                                         height: height * 0.04,
//                                         text: '')
//                                   ]),
//                                 ]),
//                               ]),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: height * 0.04,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Nadal Wins",
//                       style: finito,
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.01,
//                 ),
//                 Divider(
//                   thickness: 2,
//                   color: AppColor.maincolor,
//                   height: 5,
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Circolo1",
//                       style: title18BlackStyle,
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Indirizzo:",
//                       style: subTitle16LightGreyStyle,
//                     ),
//                     SizedBox(
//                       width: width * 0.06,
//                     ),
//                     Text(
//                       "Centro Sportivo Giovani \n Cimabue, Milano     ",
//                       style: subTitle16BlackStyle,
//                     )
//                   ],
//                 ),
//                 Divider(
//                   thickness: 2,
//                   color: AppColor.maincolor,
//                   height: 5,
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Servizi",
//                       style: title18BlackStyle,
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.03,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Bar",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: val,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: val,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Spogliatoi",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: vals,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vals,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Vendita palline ",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: valss,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: valss,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Negozio interno",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: valsss,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: valsss,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       " Servizio incordatura",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: vc,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vc,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Ristorante",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: vcs,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vcs,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Divider(
//                   thickness: 2,
//                   color: AppColor.maincolor,
//                   height: 5,
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Campi",
//                       style: title18BlackStyle,
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.03,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Play it",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: vcss,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vcss,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Cemento",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: vcsa,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vcsa,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Terra",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: vcsb,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vcsb,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Erba",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: valq,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: valq,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Luci",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: valqq,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: valqq,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Riscldamento",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: za,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: za,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Coperto",
//                       style: text_color,
//                     ),
//                     Spacer(),
//                     CustomRadioButton(
//                         val: zaa,
//                         value: "1",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: zaa,
//                         value: "2",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Center(
//                   child: CustomButton(
//                       color: AppColor.buttonnewcolor,
//                       width: width * 0.7,
//                       height: height * 0.05,
//                       text: 'Salva',
//                       onpressed: (() {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => Lessonfinito()));
//                       })),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
