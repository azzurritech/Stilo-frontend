// import 'package:flutter/material.dart';

// import '../utilities/constant/colors.dart';
// import '../utilities/constant/heading_text_style.dart';
// import '../utilities/constant/image_path.dart';
// import '../widgets/app_bar_widget.dart';
// import '../widgets/button_widgets.dart';
// import '../widgets/circle_widget.dart';
// import 'match_finito.dart';

// class PrenatoOrganisato extends StatefulWidget {
//   const PrenatoOrganisato({super.key});

//   @override
//   State<PrenatoOrganisato> createState() => _PrenatoOrganisatoState();
// }

// class _PrenatoOrganisatoState extends State<PrenatoOrganisato> {
//   DateTime today = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBarWidget(
//         title: 'Chaalenge',
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 27.0, horizontal: 12),
//             child: Column(
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
//                             radius: 50, images: ImagePath.rafaellogo),
//                         Text(
//                           "Novak",
//                           style: title18BlackStyle,
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.05,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Circolo 1",
//                         style: title18BlackStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Indirizzo:   ",
//                         style: subTitle16LightGreyStyle,
//                       ),
//                       Text(
//                         "Centro Sportivo Giovani \n Cimabue, Milano     ",
//                         style: subTitle16BlackStyle,
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: height * 0.03,
//                 ),
//                 CustomButton(
//                     height: height * 0.06,
//                     width: width * 0.35,
//                     text: 'Show directions',
//                     style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500),
//                     onpressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: ((context) => Matchfinito())));
//                     }),
//                 SizedBox(
//                   height: height * 0.03,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           Container(
//                             height: height * 0.04,
//                             width: width * 0.4,
//                             decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 5,
//                                     blurRadius: 7,
//                                     offset: Offset(
//                                         2, 9), // changes position of shadow
//                                   ),
//                                 ],
//                                 color: AppColor.containercolor,
//                                 borderRadius: BorderRadius.circular(18)),
//                             child: Center(
//                               child: Text(
//                                 "Date: 24.12.2022 ",
//                                 style: subTitle16BlackStyle,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         height: height * 0.04,
//                         width: width * 0.3,
//                         decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 5,
//                                 blurRadius: 7,
//                                 offset:
//                                     Offset(2, 9), // changes position of shadow
//                               ),
//                             ],
//                             color: AppColor.containercolor,
//                             borderRadius: BorderRadius.circular(18)),
//                         child: Center(
//                           child: Text(
//                             "Time:  20:00",
//                             style: subTitle16BlackStyle,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: height * 0.03,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Note",
//                         style: subTitle16BlackStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: height * 0.01,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Lorem ipsum dolor sit amet, consectetur \n adipiscing elit, sed do eiusmod tempor \n  incididunt ut labore et dolore magna aliqua.",
//                         style: subTitle16BlackStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: height * 0.05,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 32.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 5,
//                             blurRadius: 7,
//                             offset: Offset(2, 9), // changes position of shadow
//                           ),
//                         ],
//                         color: AppColor.containercolor,
//                         borderRadius: BorderRadius.circular(18)),
                  
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
