// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_wanna_play_app/View/prenatato_organisato.dart';

// import '../utilities/constant/colors.dart';
// import '../utilities/constant/heading_text_style.dart';
// import '../utilities/constant/image_path.dart';
// import '../widgets/app_bar_widget.dart';
// import '../widgets/button_widgets.dart';
// import '../widgets/circle_widget.dart';
// import '../widgets/custom_sized_box_widget.dart';
// import '../widgets/textfield_widget.dart';

// class Challengeprenatato extends StatelessWidget {
//   const Challengeprenatato({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 27.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Column(
//                     children: [
//                       CustomCircleAvatar(
//                           radius: 50, images: ImagePath.loginlogo),
//                       Text(
//                         'You',
//                         style: title18BlackStyle,
//                       )
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         "Vs",
//                         style: vscolor,
//                       ),
//                       Image.asset(ImagePath.lessonball)
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       CustomCircleAvatar(
//                           radius: 50, images: ImagePath.rafaellogo),
//                       Text(
//                         "Novak",
//                         style: title18BlackStyle,
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//               CustomSizedBox(
//                 height: height * 0.05,
//               ),
//               TextFields(
//                 height: height * 0.06,
//                 width: width * 0.8,
//                 text: 'Circolo',
//               ),
//               CustomSizedBox(
//                 height: height * 0.04,
//               ),
//               TextFields(
//                 height: height * 0.06,
//                 width: width * 0.8,
//                 text: 'Date',
//               ),
//               CustomSizedBox(
//                 height: height * 0.04,
//               ),
//               TextFields(
//                 height: height * 0.06,
//                 width: width * 0.8,
//                 text: 'Time',
//               ),
//               CustomSizedBox(
//                 height: height * 0.04,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                 child: TextField(
//                   maxLines: 8,
//                   decoration: new InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.grey, width: 2.0),
//                     ),
//                     hintText: 'Note',
//                   ),
//                 ),
//               ),
//               const Spacer(
//                 flex: 9,
//               ),
//               CustomButton(
//                   width: width * 0.8,
//                   height: height * 0.06,
//                   text: 'Save',
//                   onpressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: ((context) => PrenatoOrganisato())));
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
