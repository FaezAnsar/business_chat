import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/crud/cloud_class.dart';
import 'package:business_chat/crud/cloud_storage.dart';
import 'package:business_chat/crud/database.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

Future<void> RoomCreationPopUp(BuildContext context, Map map) async {
  //final key = Uuid().v4();

  final _businessService = FirebaseCloudStorage();
  final org = await (_businessService.createOrganisation(
    name: map[nameField],
    owner_name: map[ownerNameField],
    owner_cnic: int.parse(map[ownerCnicField]),
    email: map[emailField],
  ));
  map.addEntries({organisationIdField: org.id}.entries);
  final employee = await (_businessService.createEmployee(
      name: map[ownerNameField],
      role: 'owner',
      employeeCnic: int.parse(map[ownerCnicField]),
      email: map[emailField],
      organisationId: org.id));
  map.addEntries({employeeIdField: employee.id}.entries);
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
                  child: Text(org.id),
                ),
                TextButton(
                  onPressed: () async {
                    FlutterClipboard.copy(org.id).then(
                      (value) async {
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
                Navigator.of(context).pushNamedAndRemoveUntil(
                    homePageRoute, (route) => false,
                    arguments: map);
              },
              child: Text("Join Room"))
        ],
      );
    },
  );
}
