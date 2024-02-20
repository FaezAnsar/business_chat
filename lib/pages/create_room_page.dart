import 'package:business_chat/pop_ups/room_creation_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CreateRoomPage extends StatelessWidget {
  const CreateRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter Owner Name", labelText: "Owner Name"),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter Owner CNIC", labelText: "Owner Cnic"),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter Organisation's Name",
                  labelText: "Organisation's Name"),
            ),
            Center(
                child: TextButton(
              onPressed: () {
                RoomCreationPopUp(context);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amber)),
              child: Text("Create Room"),
            ))
          ],
        ));
  }
}
