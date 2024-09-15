import 'package:business_chat/constants/routes.dart';
import 'package:business_chat/crud/cloud_class.dart';
import 'package:business_chat/crud/cloud_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> RoomJoinedPopUp(BuildContext context, Map map) async {
  final _businessService = FirebaseCloudStorage();
  if (map[alreadyJoined] == 'No') {
    final employee = await (_businessService.createEmployee(
        name: map[nameField],
        role: map[roleField],
        employeeCnic: int.parse(map[employeeCnicField]),
        email: map[emailField],
        organisationId: map[organisationIdField]));
    map.addEntries({employeeIdField: employee.id}.entries);
  }
  //have to add eployee id incase of "Yes"
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
                Navigator.of(context).pushNamed(homePageRoute, arguments: map);
              },
              child: Text("Ok"))
        ],
      );
    },
  );
}

Future<bool> organisationNotPresent(Map map) async {
  final organisations =
      (await FirebaseCloudStorage().getAllOrganisation()).toList();
  for (final org in organisations) {
    if (org.id == map[organisationIdField]) {
      return false;
    }
  }
  return true;
}

Future<bool> isalreadyJoined(User user, Map map) async {
  final _businessService = FirebaseCloudStorage();
  // _businessService.orgId = map[organisationIdColumn];
  final email = FirebaseAuth.instance.currentUser!.email;
  final employees = (await _businessService.getAllEmployees(
          organisationId: map[organisationIdField]))
      .toList();
  print(employees);
  for (final e in employees) {
    //print("${e.email == email} in loop");
    if ((e.email == email && e.organisationId == map[organisationIdField])
        // ||
        //     (e.employee_cnic == map[employeeCnicColumn] &&
        //         e.organisation_id == map[organisationIdColumn])
        ) {
      map.addEntries({employeeIdField: e.id}.entries);
      return true;
    }
  }
  print('ff');
  return false;
}

const String alreadyJoined = 'alreadyJoined';
