// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';


// import '../Controller/search_controller.dart';
// import '../Model/user_model.dart';
// import '../helper/basehelper.dart';
// import '../utilities/constant/colors.dart';
// import '../utilities/constant/heading_text_style.dart';
// import '../widgets/app_bar_widget.dart';
// import '../widgets/custom_container.dart';

// class MatchInvitationSend extends StatelessWidget {
//   MatchInvitationSend({
//     super.key,
//     required this.isCoach,
//   });

//   List<DocumentSnapshot<UserModel>>? doc;
//   final bool isCoach;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWidget(title: '', action: []),
//       body: StreamBuilder(
//           stream: BaseHelper.firestore
//               .collection('users')
//               .withConverter(
//                   fromFirestore: UserModel.fromFireStore,
//                   toFirestore: (UserModel user, options) => user.toFireStore())
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               doc = snapshot.data?.docs;

//               if (doc?.length == 0) {
//                 return Center(
//                   child: Text(
//                     "No record found",
//                     style: heading22BlackStyle,
//                   ),
//                 );
//               } else {
//                 // return searchListViewWidget(doc, users, true);
//               }
//             } else if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator.adaptive());
//             } else if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator.adaptive(),
//               );
//             }
//             return Container();
//           }),
//     );
//   }
// }
