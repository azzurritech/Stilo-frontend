// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_rating_stars/flutter_rating_stars.dart';

// import '../utilities/constant/colors.dart';
// import '../utilities/constant/heading_text_style.dart';
// import '../utilities/constant/image_path.dart';
// import '../widgets/app_bar_widget.dart';
// import '../widgets/button_widgets.dart';
// import '../widgets/circle_widget.dart';
// import '../widgets/custom_sized_box_widget.dart';
// import 'chat_with_user.dart';

// class CoachInvite extends StatefulWidget {
//   const CoachInvite({super.key});

//   @override
//   State<CoachInvite> createState() => _CoachInviteState();
// }

// class _CoachInviteState extends State<CoachInvite> {
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBarWidget(
//         title: 'Rafael Nadal',
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Container(
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CustomSizedBox(
//                 height: height * 0.05,
//               ),
//               Container(
//                 child: CustomCircleAvatar(
//                     radius: 80, images: ImagePath.rafaelimage),
//               ),
//               CustomSizedBox(
//                 height: height * 0.04,
//               ),
//               Text(
//                 'Rafael Nadal',
//                 style: heading22BlackStyle,
//               ),
//               CustomSizedBox(
//                 height: height * 0.015,
//               ),
//               CustomSizedBox(
//                 height: height * 0.02,
//               ),
//               Text(
//                 'Giocatore',
//                 style: title18BlackStyle,
//               ),
//               CustomSizedBox(
//                 height: height * 0.2,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 5,
//                         blurRadius: 7,
//                         offset: Offset(2, 9), // changes position of shadow
//                       ),
//                     ],
//                     color: AppColor.containbackgeround,
//                     borderRadius: BorderRadius.circular(18)),
//                 height: height * 0.2,
//                 width: width * 0.8,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Citta :   Milano',
//                             style: title18WhiteStyle,
//                           ),
//                         ],
//                       ),

//                       Padding(
//                         padding: const EdgeInsets.only(top: 27.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               'FederAzione ranking: 2 ',
//                               style: title18WhiteStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Mantiene la classifica',
//                             style: title18WhiteStyle,
//                           ),
//                         ],
//                       ),
//                       // CustomSizedBox(
//                       //   height: height * 0.01,
//                       // ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 9.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Eta: 28',
//                               style: title18WhiteStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Spacer(
//                 flex: 4,
//               ),
//               CustomButton(
//                   color: AppColor.buttonnewcolor,
//                   width: width * 0.7,
//                   height: height * 0.05,
//                   text: 'Open Chat',
//                   imgpath: ImagePath.chatgio,
//                   onpressed: () {
//                     // isplaying = true;
//                     // Navigator.of(context).push(MaterialPageRoute(
//                     //     builder: ((context) => Chatwithuser(
//                     //           text: 'Rafael Nadal',
//                     //         ))));
//                   }),
//               CustomSizedBox(
//                 height: height * 0.04,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
