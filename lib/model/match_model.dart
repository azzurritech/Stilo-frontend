// import 'package:cloud_firestore/cloud_firestore.dart';

// class MatchModel {
 

//   final String opponentEmail;

//   final String profilePhoto;
//   final DateTime time;
//   MatchModel({
//     required this.profilePhoto,
//     required this.name,
//     required this.opponentEmail,

//     required this.time,
//   });

//   Map<String, dynamic> toFireStore() {

//     return {
   
//       "opponentEmail": opponentEmail,
//       "timeStamp": time,

//       "profilePhoto": profilePhoto,
//     };
//   }

//   factory MatchModel.fromFireStore(
//       DocumentSnapshot<Map<String, dynamic>> snapshot,
//       SnapshotOptions? options) {
//     var data = snapshot.data();
//     DateTime date = (data?['timeStamp'] as Timestamp).toDate();
//     return MatchModel(
//       opponentEmail: data?['opponentEmail'] ?? "",
//       name: data?["name"] ?? "",
//       profilePhoto: data?['profilePhoto'] ?? "",
//       type: data?['type'] ?? "",
//       time: date,
//     );
//   }
// }


// // 
// //                         SnapshotOptions() options