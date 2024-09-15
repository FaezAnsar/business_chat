import 'package:cloud_firestore/cloud_firestore.dart';

class CloudOrganisation {
  final String id;
  final String name;
  final String owner_name;
  final int owner_cnic;
  final String email;

  CloudOrganisation(
      {required this.id,
      required this.name,
      required this.owner_name,
      required this.owner_cnic,
      required this.email});
  CloudOrganisation.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        name = snapshot.data()[nameField],
        owner_name = snapshot.data()[ownerNameField],
        owner_cnic = snapshot.data()[ownerCnicField],
        email = snapshot.data()[emailField];
}

class CloudEmployee {
  final String id;
  final String name;
  final String role;
  final int employee_cnic;
  final String email;
  final String organisationId;

  CloudEmployee(
      {required this.id,
      required this.name,
      required this.role,
      required this.employee_cnic,
      required this.email,
      required this.organisationId});

  CloudEmployee.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        name = snapshot.data()[nameField],
        role = snapshot.data()[roleField],
        employee_cnic = snapshot.data()[employeeCnicField],
        email = snapshot.data()[emailField],
        organisationId = snapshot.data()[organisationIdField];
}

class CloudAnnouncement {
  final String id;
  final String to;
  final String from;
  final String message;
  final String organisationId;
  final String employeeId;

  CloudAnnouncement(
      {required this.employeeId,
      required this.id,
      required this.to,
      required this.from,
      required this.message,
      required this.organisationId});

  CloudAnnouncement.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        to = snapshot.data()[toField],
        from = snapshot.data()[fromField],
        message = snapshot.data()[messageField],
        organisationId = snapshot.data()[organisationIdField],
        employeeId = snapshot.data()[employeeIdField];
}

// class CloudChat{
//   final String id;
//   final String organisation_id;

//   CloudChat({required this.id, required this.organisation_id});
//   CloudChat.fromSnapshot(QueryDocumentSnapshot<Map<String,dynamic>>snapshot):id=snapshot.id,organisation_id=snapshot.data()[organisationIdField];

// }

class CloudMessage {
  final String id;
  final String senderId;
  final String receiverId;
  bool messageSeen = false;
  final String organisationId;
  final Timestamp timeSent;
  final String message;

  CloudMessage(
      {required this.id,
      required this.senderId,
      required this.receiverId,
      required this.organisationId,
      required this.timeSent,
      required this.message});

  CloudMessage.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        senderId = snapshot.data()[fromField],
        receiverId = snapshot.data()[toField],
        messageSeen = snapshot.data()[messageSeenField],
        message = snapshot.data()[messageField],
        organisationId = snapshot.data()[organisationIdField],
        timeSent = snapshot.data()[timeSentField];
}

const toField = 'to';
const fromField = 'from';
const messageField = 'message';
const roleField = 'role';
const employeeCnicField = 'employee_cnic';
const organisationIdField = 'organisation_id';
const nameField = 'name';
const ownerNameField = 'owner_name';
const ownerCnicField = 'owner_cnic';
const emailField = 'email';
const employeeIdField = 'employee_id';

//chat constants

const timeSentField = 'time_sent';
const messageSeenField = 'message_seen';
const lastSeenField = 'last_seen';
const onlineField = 'online';
