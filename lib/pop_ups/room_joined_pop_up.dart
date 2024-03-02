import 'package:business_chat/constants/routes.dart';
import 'package:flutter/material.dart';

Future<void> RoomJoinedPopUp(BuildContext context, Map map) {
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
                Navigator.of(context).pushNamedAndRemoveUntil(
                    homePageRoute, (route) => false,
                    arguments: map);
              },
              child: Text("Ok"))
        ],
      );
    },
  );
}
