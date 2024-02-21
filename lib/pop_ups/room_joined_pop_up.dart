import 'package:flutter/material.dart';

Future<void> RoomJoinedPopUp(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Organisation's key"),
        content: Text("Room successfully joined"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"))
        ],
      );
    },
  );
}
