import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/crud/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              onPressed: () async {
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

Future<bool> organisationNotPresent(Map map) async {
  final organisations = (await BusinessService().getAllOrganisation()).toList();
  for (final org in organisations) {
    if (org.id == map[organisationIdColumn]) {
      return false;
    }
  }
  return true;
}

Future<bool> isalreadyJoined(User user, Map map) async {
  final _businessService = BusinessService();
  _businessService.orgId = map[organisationIdColumn];
  final email = FirebaseAuth.instance.currentUser!.email;
  final employees = (await _businessService.getAllEmployees()).toList();
  print(employees);
  for (final e in employees) {
    print("${e.email == email} in loop");
    if ((e.email == email && e.organisation_id == map[organisationIdColumn])
        // ||
        //     (e.employee_cnic == map[employeeCnicColumn] &&
        //         e.organisation_id == map[organisationIdColumn])
        ) {
      return true;
    }
  }
  print('ff');
  return false;
}

const String alreadyJoined = 'alreadyJoined';
