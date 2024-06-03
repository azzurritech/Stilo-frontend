// import 'package:flutter/material.dart';

// import '../View/challenge_prenatato.dart';
// import '../utilities/constant/colors.dart';
// import '../utilities/constant/heading_text_style.dart';
// import 'button_widgets.dart';
// import 'custom_sized_box_widget.dart';

// Future<Future> popupaccpet(context) async {
//   final height = MediaQuery.of(context).size.height;
//   final width = MediaQuery.of(context).size.width;
//   return showDialog(
//       builder: (BuildContext context) {
//         return Container(
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(17)),
//           child: Center(
//             child: Container(
//               height: height * 0.4,
//               child: AlertDialog(
//                 title: Text("Sei riuscito a prenotare?"),
//                 content: Column(
//                   children: [
//                     CustomButton(
//                         style: subTitle16DarkGreyStyle,
//                         height: height * 0.05,
//                         width: width * 0.5,
//                         text: "Si",
//                         color: AppColor.divivdercolor,
//                         onpressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) =>
//                                   const Challengeprenatato()));
//                         }),
//                     CustomSizedBox(
//                       height: height * 0.02,
//                     ),
//                     CustomButton(
//                         height: height * 0.05,
//                         width: width * 0.5,
//                         text: "No",
//                         color: AppColor.refusecolor,
//                         onpressed: () {}),
//                     CustomSizedBox(
//                       height: height * 0.02,
//                     ),
//                     CustomButton(
//                         style: title18WhiteStyle,
//                         height: height * 0.07,
//                         width: width * 0.5,
//                         text: "Condividi \n Prenotazione",
//                         color: AppColor.maincolor,
//                         onpressed: () {}),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       context: context);
// }
