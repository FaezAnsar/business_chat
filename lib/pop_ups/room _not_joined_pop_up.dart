import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/pop_ups/room_joined_pop_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> RoomNotJoinedPopUp(BuildContext context, Map map) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Invalid Organisation key"),
        content: Text("No org is associated with the entered key"),
        actions: [
          TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text("Ok"))
        ],
      );
    },
  );
}
