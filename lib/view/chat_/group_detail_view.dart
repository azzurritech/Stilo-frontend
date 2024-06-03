import 'package:flutter/material.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.green[300],
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   groupDetail.name,
                //   style: TextStyle(
                //     fontSize: 24.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                SizedBox(height: 10.0),
                // Text(
                //   groupDetail.description,
                //   style: TextStyle(fontSize: 18.0),
                // ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Members:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: groupDetail.members.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(groupDetail.members[index]),
          //         leading: CircleAvatar(
          //           child: Text(groupDetail.members[index][0]),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}