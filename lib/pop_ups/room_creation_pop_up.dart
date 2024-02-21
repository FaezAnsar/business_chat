import 'package:business_chat/constants/routes.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

Future<void> RoomCreationPopUp(BuildContext context) {
  final key = Uuid().v4();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Organisation's key"),
        content: Column(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(key),
                ),
                TextButton(
                  onPressed: () async {
                    FlutterClipboard.copy(key).then(
                      (value) {
                        Navigator.of(context).pop();
                        return ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Text Copied'),
                          ),
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  child: const Icon(Icons.copy),
                ),
              ],
            ),
            Text("Your Employees can join your room using the above key"),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(homePageRoute, (route) => false);
              },
              child: Text("Join Room"))
        ],
      );
    },
  );
}
