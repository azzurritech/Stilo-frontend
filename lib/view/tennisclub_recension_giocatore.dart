// import 'package:flutter/material.dart';

// import '../utilities/constant/colors.dart';
// import '../utilities/constant/heading_text_style.dart';
// import '../utilities/constant/image_path.dart';
// import '../widgets/app_bar_widget.dart';
// import '../widgets/button_widgets.dart';
// import '../widgets/circle_widget.dart';
// import '../widgets/radio_button_widgets.dart';

// class TennisClubRecension extends StatefulWidget {
//   const TennisClubRecension({super.key});

//   @override
//   State<TennisClubRecension> createState() => _TennisClubRecensionState();
// }

// class _TennisClubRecensionState extends State<TennisClubRecension> {
//   String val = "1";
//   String vals = "1";
//   String valss = "1";
//   String valsss = "1";
//   String vc = "1";
//   String vcs = "1";

//   String vza = "1";
//   String vzb = "1";
//   String vzc = "1";
//   String vzd = "1";
//   String vze = "1";
//   String vzf = "1";
//   String vcss = "1";
//   DateTime today = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBarWidget(
//         title: 'Tennis  Club',
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
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           "Tennis Club Lightgreen",
//                           style: vscolor,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 // Divider(
//                 //   thickness: 3,
//                 //   color: Appcolor.divivdercolor,
//                 //   height: 5,
//                 // ),

//                 Container(
//                   child: Row(
//                     children: [],
//                   ),
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
//                     Text("Centro Sportivo Lightgreen \n Segrate, Milano")
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Divider(
//                   thickness: 3,
//                   color: AppColor.divivdercolor,
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
//                         value: "Si",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: val,
//                         value: "No",
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
//                         value: "Si",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vals,
//                         value: "No",
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
//                         value: "Si",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: valss,
//                         value: "No",
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
//                         value: "Si",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: valsss,
//                         value: "No",
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
//                         value: "Si",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vc,
//                         value: "No",
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
//                         value: "SI",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vcs,
//                         value: "No",
//                         text: 'No',
//                         style: text_color,
//                         onChanged: ((p0) {}))
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Divider(
//                   thickness: 3,
//                   color: AppColor.divivdercolor,
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
//                         value: "Si",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vcss,
//                         value: "No",
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
//                     const Spacer(),
//                     CustomRadioButton(
//                         val: vza,
//                         value: "SI",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vza,
//                         value: "No",
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
//                     const Spacer(),
//                     CustomRadioButton(
//                         val: vzb,
//                         value: "Si",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vzb,
//                         value: "No",
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
//                     const Spacer(),
//                     CustomRadioButton(
//                         val: vzc,
//                         value: "Si",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vzc,
//                         value: "No",
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
//                     const Spacer(),
//                     CustomRadioButton(
//                         val: vzd,
//                         value: "Si",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vzd,
//                         value: "No",
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
//                     const Spacer(),
//                     CustomRadioButton(
//                         val: vze,
//                         value: "Si",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vze,
//                         value: "No",
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
//                     const Spacer(),
//                     CustomRadioButton(
//                         val: vzf,
//                         value: "Si",
//                         text: 'Si',
//                         style: text_color,
//                         onChanged: ((p0) {})),
//                     CustomRadioButton(
//                         val: vzf,
//                         value: "No",
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
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Tenuto bene",
//                       style: text_color,
//                     ),
//                     const Spacer(),
//                     // CustomRating()
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Organizza tornei",
//                       style: text_color,
//                     ),
//                     const Spacer(),
//                     // CustomRating()
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Rapporto quaità-prezzo",
//                       style: text_color,
//                     ),
//                     const Spacer(),
//                     // CustomRating()
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Cortesia e disponibilità",
//                       style: text_color,
//                     ),
//                     const Spacer(),
//                     // CustomRating()
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       " Professionalità",
//                       style: text_color,
//                     ),
//                     const Spacer(),
//                     // CustomRating()
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Center(
//                   child: CustomButton(
//                       width: width * 0.7,
//                       height: height * 0.05,
//                       text: 'Salva',
//                       color: AppColor.buttonnewcolor,
//                       onpressed: (() {})),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
