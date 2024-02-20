import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

Future<void> RoomCreationPopUp(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Organisation's key"),
        content: Column(
          children: [
            Text(Uuid().v4()),
            Text("Your Employees can join your room using the above key")
          ],
        ),
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
