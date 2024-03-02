import 'package:business_chat/crud/database.dart';
import 'package:business_chat/pop_ups/room_joined_pop_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JoinRoomPage extends StatelessWidget {
  JoinRoomPage({super.key});

  final TextEditingController _employeeName = TextEditingController();
  final TextEditingController _employeeCnic = TextEditingController();
  final TextEditingController _employeeRole = TextEditingController();
  final TextEditingController _orgKey = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextFormField(
              controller: _employeeName,
              decoration: InputDecoration(
                  hintText: "Enter your  Name", labelText: "Employee Name"),
            ),
            TextFormField(
              controller: _employeeCnic,
              decoration: InputDecoration(
                  hintText: "Enter your CNIC", labelText: "Employee Cnic"),
            ),
            TextFormField(
              controller: _employeeRole,
              decoration: InputDecoration(
                  hintText: "Enter your role ",
                  labelText: "Role in Organisation"),
            ),
            TextFormField(
              controller: _orgKey,
              decoration: InputDecoration(
                  hintText: "Enter Organisation's key",
                  labelText: "Organisation's key"),
            ),
            Center(
                child: TextButton(
              onPressed: () async {
                final email = await FirebaseAuth.instance.currentUser!.email!;

                final Map<String, String> map = {
                  'type': 'join',
                  organisationIdColumn: _orgKey.text,
                  emailColumn: email,
                  nameColumn: _employeeName.text,
                  roleColumn: _employeeRole.text,
                  employeeCnicColumn: _employeeCnic.text
                };

                RoomJoinedPopUp(context, map);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amber)),
              child: Text("Join Room"),
            ))
          ],
        ));
  }
}
