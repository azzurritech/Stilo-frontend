// import 'package:flutter/material.dart';

// import '../utilities/constant/button_text_style.dart';
// import '../utilities/constant/colors.dart';
// import '../utilities/constant/heading_text_style.dart';
// import '../utilities/constant/image_path.dart';
// import '../widgets/app_bar_widget.dart';
// import '../widgets/button_widgets.dart';
// import '../widgets/circle_widget.dart';
// import '../widgets/custom_sized_box_widget.dart';

// class InvitationNotification extends StatelessWidget {
//   const InvitationNotification({super.key});

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
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CustomSizedBox(
//                 height: height * 0.05,
//               ),
//               Container(
//                 width: 182,
//                 height: 182,
//                 child: CustomCircleAvatar(
//                     radius: 50, images: ImagePath.rafaellogo),
//               ),
//               CustomSizedBox(
//                 height: height * 0.04,
//               ),
//               Text(
//                 'Roger Federer',
//                 style: heading22BlackStyle,
//               ),
//               CustomSizedBox(
//                 height: height * 0.015,
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
//                     color: AppColor.containercolor,
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
//                             style: title18BlackStyle,
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
//                               style: title18BlackStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Mantiene la classifica',
//                             style: hint_text,
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
//                               style: title18BlackStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const Spacer(
//                 flex: 4,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CustomButton(
//                       width: width * 0.7,
//                       height: height * 0.05,
//                       text: 'Invita',
//                       color: AppColor.buttonnewcolor,
//                       onpressed: () {
//                         // Navigator.of(context).push(MaterialPageRoute(
//                         //     builder: (context) =>  AcceptInvite()));
//                       }),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
