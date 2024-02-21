import 'package:business_chat/pop_ups/room_creation_pop_up.dart';
import 'package:flutter/material.dart';

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
              // validator: (value) {
              //   if (value == null) return "Field can't be empty";
              //   return value;
              // },
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter Owner CNIC", labelText: "Owner Cnic"),
              // validator: (value) {
              //   if (value == null)
              //     return "Field can't be empty";
              //   else if (value.length < 15) return "Enter 15 digits";
              //   return value;
              // },
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
