import 'package:business_chat/crud/cloud_class.dart';
import 'package:business_chat/crud/database.dart';
import 'package:business_chat/pop_ups/room_creation_pop_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CreateRoomPage extends StatelessWidget {
  final TextEditingController _ownerName = TextEditingController();
  final TextEditingController _ownerCnic = TextEditingController();
  final TextEditingController _orgName = TextEditingController();

  CreateRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextFormField(
              controller: _ownerName,
              decoration: InputDecoration(
                  hintText: "Enter Owner Name", labelText: "Owner Name"),
              // validator: (value) {
              //   if (value == null) return "Field can't be empty";
              //   return value;
              // },
            ),
            TextFormField(
              controller: _ownerCnic,
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
              controller: _orgName,
              decoration: InputDecoration(
                  hintText: "Enter Organisation's Name",
                  labelText: "Organisation's Name"),
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  final email = await FirebaseAuth.instance.currentUser!.email!;

                  final Map<String, String> map = {
                    'type': 'create',
                    emailField: email,
                    nameField: _orgName.text,
                    ownerNameField: _ownerName.text,
                    ownerCnicField: _ownerCnic.text
                  };
                  RoomCreationPopUp(context, map);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                child: Text("Create Room"),
              ),
            )
          ],
        ));
  }
}
