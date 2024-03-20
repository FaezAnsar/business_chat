import 'package:business_chat/crud/cloud_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseCloudStorage {
  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;

  final organisations = FirebaseFirestore.instance.collection('organisations');

  Future<CloudOrganisation> createOrganisation(
      {
      //required String id,
      required String name,
      required String owner_name,
      required int owner_cnic,
      required String email}) async {
    final org = await organisations.add(
      {
        nameField: name,
        ownerNameField: owner_name,
        ownerCnicField: owner_cnic,
        emailField: email,
      },
    );

    return CloudOrganisation(
        id: org.id, //check this
        name: name,
        owner_name: owner_name,
        owner_cnic: owner_cnic,
        email: email);
  }

  Future<Iterable<CloudEmployee>> getAllEmployees(
      {required String organisationId}) async {
    return await organisations
        .doc(organisationId)
        .collection('employees')
        .get()
        .then((value) => value.docs.map((e) => CloudEmployee.fromSnapshot(e)));
  }

  Future<Iterable<CloudOrganisation>> getAllOrganisation() async {
    return await organisations.get().then(
        (value) => value.docs.map((e) => CloudOrganisation.fromSnapshot(e)));
  }

  // Future<Iterable<CloudAnnouncement>> getAllAnnouncements(
  //     {required String organisationId}) async {
  //   final employees = await getAllEmployees(organisationId: organisationId);
  //   print(employees.length);
  //   List<CloudAnnouncement> announcements = [];
  //   for (final employee in employees) {
  //     print(employee.id);
  //     final announcement = await organisations
  //         .doc(organisationId)
  //         .collection('employees')
  //         .doc(employee.id)
  //         .collection('announcements')
  //         .get()
  //         .then((value) => value.docs
  //             .map((e) => CloudAnnouncement.fromSnapshot(e))
  //             .toList());
  //     announcements = announcements + announcement;
  //     print(announcements);
  //   }
  //   print('JJJ');
  //   print(announcements);
  //   print(";((()))");
  //   return announcements;
  // }
  Future<Iterable<CloudAnnouncement>> getAllAnnouncements(
      {required String organisationId}) async {
    final employees = await getAllEmployees(organisationId: organisationId);
    print('Total Employees: ${employees.length}');

    List<CloudAnnouncement> announcements = [];
    for (final employee in employees) {
      print('Fetching announcements for employee ID: ${employee.id}');
      try {
        final snapshot = await organisations
            .doc(organisationId)
            .collection('employees')
            .doc(employee.id)
            .collection('announcements')
            .get();

        final employeeAnnouncements = snapshot.docs
            .map((doc) => CloudAnnouncement.fromSnapshot(doc))
            .toList();

        announcements.addAll(employeeAnnouncements);
        print(
            'Announcements for employee ID ${employee.id}: $employeeAnnouncements');
      } catch (e) {
        print(
            'Error fetching announcements for employee ID ${employee.id}: $e');
      }
    }

    print('Total Announcements: ${announcements.length}');
    return announcements;
  }

  Future<CloudEmployee> createEmployee(
      {
      //required String docId,
      required String name,
      required String role,
      required int employeeCnic,
      required String email,
      required String organisationId}) async {
    final employee =
        await organisations.doc(organisationId).collection('employees').add({
      nameField: name,
      roleField: role,
      employeeCnicField: employeeCnic,
      emailField: email,
      organisationIdField: organisationId
    });

    final fetchedEmployee = await employee.get();
    return CloudEmployee(
        id: fetchedEmployee.id,
        name: name,
        role: role,
        employee_cnic: employeeCnic,
        email: email,
        organisationId: organisationId);
  }

  Future<void> deleteEmployee(
      {required String orgId, required CloudEmployee employee}) async {
    await organisations
        .doc(employee.organisationId)
        .collection('employees')
        .doc(employee.id)
        .delete();
  }

  void deleteAnnouncement({required CloudAnnouncement announcement}) async {
    await organisations
        .doc(announcement.organisationId)
        .collection('employees')
        .doc(announcement.employeeId)
        .collection('announcements')
        .doc(announcement.id)
        .delete();
  }

  Future<void> updateAnnouncement({
    required CloudAnnouncement announcement,
    required String message,
    required String to,
  }) async {
    await organisations
        .doc(announcement.organisationId)
        .collection('employees')
        .doc(announcement.employeeId)
        .collection('announcements')
        .doc(announcement.id)
        .update({
      toField: to,
      messageField: message,
    });
  }

  Future<CloudAnnouncement> createAnnouncement(
      {required employeeId,
      required String to,
      required String from,
      required String message,
      required String organisationId}) async {
    final org = await organisations
        .doc(organisationId)
        .collection('employees')
        .doc(employeeId)
        .collection('announcements')
        .add({
      employeeIdField: employeeId,
      toField: to,
      fromField: from,
      messageField: message,
      organisationIdField: organisationId
    });
    final fetchedAnnouncement = await org.get();
    return CloudAnnouncement(
        employeeId: employeeId,
        id: fetchedAnnouncement.id,
        to: to,
        from: from,
        message: message,
        organisationId: organisationId);
  }
}
