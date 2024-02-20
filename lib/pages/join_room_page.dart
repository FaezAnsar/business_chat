import 'package:flutter/material.dart';

class JoinRoomPage extends StatelessWidget {
  const JoinRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter your  Name", labelText: "Employee Name"),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter your CNIC", labelText: "Employee Cnic"),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter your role ",
                  labelText: "Role in Organisation"),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter Organisation's key",
                  labelText: "Organisation's key"),
            ),
            Center(
                child: TextButton(
              onPressed: () async {
                await RoomJoinedPopUp(context)
                    .then((_) => Navigator.of(context).pop());
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amber)),
              child: Text("Join Room"),
            ))
          ],
        ));
  }
}

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
