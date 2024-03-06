import 'dart:async';

import 'package:business_chat/crud/database_exceptions.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

class BusinessService {
  Database? _db;

  List<EmployeeDB> _employees = [];
  //List<AnnouncementDB> _announcements = [];
  String? _orgId;
  OrganisationDB? _organisation;

  set orgId(String id) => _orgId = id;
  String get orgId => _orgId ?? '';
  static final BusinessService _shared = BusinessService._sharedInstance();

  BusinessService._sharedInstance();
  factory BusinessService() => _shared;

  Future<Iterable<AnnouncementDB>> getAllAnnouncements() async {
    print("hola");
    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();

    final announcements = await db.query(announcementTable, orderBy: idColumn);
    print("quieried");
    return announcements
        .map((announcement) => (announcement[organisationIdColumn] == _orgId)
            ? AnnouncementDB.fromRow(announcement)
            : null)
        .whereNotNull();
  }

  Future<Iterable<AnnouncementDB>> getUsersAnnouncements() async {
    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();

    final announcements = await db.query(announcementTable, orderBy: idColumn);

    return announcements
        .map((announcement) => (announcement[organisationIdColumn] == orgId)
            ? AnnouncementDB.fromRow(announcement)
            : null)
        .whereNotNull();
  }

  Future<AnnouncementDB> updateAnnouncement(
      {required AnnouncementDB announcement,
      required String message,
      required String to}) async {
    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();
    final updatedCount = await db.update(
        announcementTable, {messageColumn: message, toColumn: to},
        where: 'id=?', whereArgs: [announcement.id]);
    return AnnouncementDB(
        id: announcement.id,
        to: to,
        from: announcement.from,
        message: message,
        organisation_id: announcement.organisation_id);
  }

  Future<void> deleteAnnouncement(int id) async {
    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();
    final deletedCount =
        await db.delete(announcementTable, where: 'id=?', whereArgs: [id]);
    if (deletedCount != 1) {
      print(deletedCount);
      throw CouldNotDeleteAnnouncement();
    }
    // _announcements.removeWhere((announcement) => announcement.id == id);
  }

  Future<AnnouncementDB> createAnnouncement(
      {required String to,
      required String from,
      required String message,
      required String organisation_id}) async {
    final Map<String, Object?> announcementMap = {
      toColumn: to.toLowerCase(),
      fromColumn: from.toLowerCase(),
      messageColumn: message,
      organisationIdColumn: organisation_id
    };

    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();
    print("before");
    final id = await db.insert(announcementTable, announcementMap);
    print("announcemet created");
    announcementMap.addEntries({idColumn: id}.entries);
    final announcement = AnnouncementDB.fromRow(announcementMap);
    // _announcements.add(announcement);
    return announcement;
  }

  Future<Iterable<OrganisationDB>> getUsersOrganisation(User user) async {
    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();
    final userEmail = user.email;
    final organisations = await db.query(organisationTable, orderBy: idColumn);
    print(_orgId);
    return organisations
        .map((org) => (org[emailColumn] == userEmail)
            ? OrganisationDB.fromRow(org)
            : null)
        .whereNotNull();

    // return employees
    //     .map((employee) => EmployeeDB.fromRow(employee))
    //     .whereNotNull();
  }

  Future<Iterable<OrganisationDB>> getAllOrganisation() async {
    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();

    final organisations = await db.query(organisationTable, orderBy: idColumn);
    print(_orgId);
    return organisations.map((org) => OrganisationDB.fromRow(org));
  }

  Future<Iterable<EmployeeDB>> getAllEmployees() async {
    print("getting");
    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();

    final employees = await db.query(employeeTable, orderBy: idColumn);
    print("gottt");
    print(_orgId);
    final ans = employees
        .map((employee) => (employee[organisationIdColumn] == _orgId)
            ? EmployeeDB.fromRow(employee)
            : null)
        .whereNotNull();
    return ans;

    // return employees
    //     .map((employee) => EmployeeDB.fromRow(employee))
    //     .whereNotNull();
  }

  Future<EmployeeDB> getEmployee({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();
    final employees = await db.query(
      employeeTable,
      where: 'id=?',
      whereArgs: [id],
      limit: 1,
    );
    if (employees.isEmpty) {
      throw CouldNotFindEmployee();
    } else {
      final employee = EmployeeDB.fromRow(employees.first);
      _employees.removeWhere((employee) => employee.id == id);
      _employees.add(employee);
      return employee;
    }
  }

  Future<void> deleteEmployee(int id) async {
    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();
    final deletedCount =
        await db.delete(employeeTable, where: 'id = ?', whereArgs: [id]);
    if (deletedCount != 1) {
      print(deletedCount);
      throw CouldNotDeleteEmployee();
    }
    _employees.removeWhere((employee) => employee.id == id);
  }

  Future<EmployeeDB?> createEmployee(
      {required String name,
      required String role,
      required int employeeCnic,
      required String email,
      required String organisationId}) async {
    final employeeMap = {
      nameColumn: name.toLowerCase(),
      roleColumn: role.toLowerCase(),
      employeeCnicColumn: employeeCnic,
      emailColumn: email,
      organisationIdColumn: organisationId
    };

    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();

    final currentEmployees = await db.query(employeeTable);
    bool create = true;
    for (final e in currentEmployees) {
      if (e.containsValue(employeeCnic) && e.containsValue(organisationId))
        create = false;
    }
    if (create) {
      final id = await db.insert(employeeTable, employeeMap);
      print("employee created");
      employeeMap.addEntries({idColumn: id}.entries);
      final employee = EmployeeDB.fromRow(employeeMap);
      _employees.add(employee);
      return employee;
    }
    return null;
  }

  Future<OrganisationDB> createOrganisation(
      {required String id,
      required String name,
      required String ownerName,
      required int ownerCnic,
      required String email}) async {
    final organisationMap = {
      idColumn: id,
      nameColumn: name.toLowerCase(),
      ownerNameColumn: ownerName.toLowerCase(),
      ownerCnicColumn: ownerCnic,
      emailColumn: email
    };

    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();
    print("before");
    await db.insert(organisationTable, organisationMap);
    print("org created");
    final organisation = OrganisationDB.fromRow(organisationMap);
    _organisation = organisation;
    return organisation;
  }

  Database _getDataBaseOrThrow() {
    final db = _db;
    if (db == null)
      throw DatabaseIsNotOpen();
    else
      return db;
  }

  Future<void> close() async {
    final db = _db;
    if (db == null)
      throw DatabaseIsNotOpen();
    else {
      await db.close();
      _db = null;
    }
  }

  Future<void> _ensureDbIsOpen() async {
    try {
      await open();
    } on DatabaseAlreadyOpenException {
      //to ensure not reopening again and again on hot reload
    }
  }

  Future<void> open() async {
    if (_db != null) throw DatabaseAlreadyOpenException();
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      // await databaseFactory.deleteDatabase(dbPath);
      final db = await openDatabase(dbPath);
      _db = db;

      print(dbPath);

      await db.execute(createOrganisationTable);
      await db.execute(createEmployeeTable);
      await db.execute(createAnnouncementTable);
      print("tables created ;)");
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}
// class DatabaseUser{
//   final id;
//   final email;
// }

class EmployeeDB {
  final int id;
  final String name;
  final String role;
  final int employee_cnic;
  final String email;
  final String organisation_id;

  EmployeeDB(
      {required this.id,
      required this.name,
      required this.role,
      required this.employee_cnic,
      required this.email,
      required this.organisation_id});
  EmployeeDB.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        name = map[nameColumn] as String,
        role = map[roleColumn] as String,
        employee_cnic = map[employeeCnicColumn] as int,
        email = map[emailColumn] as String,
        organisation_id = map[organisationIdColumn] as String;

  @override
  String toString() =>
      'Employee, ID = $id,Name = $name,Role = $role,EmployeeCnic  = $employee_cnic,email = $email,OrganisationId = $organisation_id';

  @override
  bool operator ==(covariant EmployeeDB other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class AnnouncementDB {
  final int id;
  final String to;
  final String from;
  final String message;
  final String organisation_id;

  AnnouncementDB(
      {required this.id,
      required this.to,
      required this.from,
      required this.message,
      required this.organisation_id});

  AnnouncementDB.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        to = map[toColumn] as String,
        from = map[fromColumn] as String,
        message = map[messageColumn] as String,
        organisation_id = map[organisationIdColumn] as String;
}

class OrganisationDB {
  final String id;
  final String name;
  final String owner_name;
  final int owner_cnic;
  final String email;

  OrganisationDB(
      {required this.id,
      required this.name,
      required this.owner_name,
      required this.owner_cnic,
      required this.email});
  OrganisationDB.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as String,
        name = map[nameColumn] as String,
        owner_name = map[ownerNameColumn] as String,
        owner_cnic = map[ownerCnicColumn] as int,
        email = map[emailColumn] as String;

  @override
  String toString() =>
      'Organistion, ID = $id,Name = $name,Owner = $owner_name,OwnerCnic  = $owner_cnic,email = $email';

  @override
  bool operator ==(covariant OrganisationDB other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const dbName = 'business_chat.db';
const organisationTable = 'organisation';
const employeeTable = 'employee';
const idColumn = 'id';
const nameColumn = 'name';
const ownerNameColumn = 'owner_name';
const ownerCnicColumn = 'owner_cnic';
const emailColumn = 'email';
const roleColumn = 'role';
const employeeCnicColumn = 'employee_cnic';
const organisationIdColumn = 'organisation_id';
const toColumn = 'to';
const fromColumn = 'from';
const messageColumn = 'message';
const announcementTable = 'announcement';

const createOrganisationTable = '''CREATE TABLE IF NOT EXISTS "organisation" (
	"id"	TEXT NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"owner_name"	TEXT NOT NULL,
	"owner_cnic"	INTEGER NOT NULL,
	"email"	TEXT NOT NULL,
	PRIMARY KEY("id")
);
);''';

const createEmployeeTable = '''CREATE TABLE IF NOT EXISTS "employee" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT,
	"role"	TEXT NOT NULL,
	"employee_cnic"	INTEGER NOT NULL,
	"email"	TEXT NOT NULL,
	"organisation_id"	TEXT NOT NULL,
	FOREIGN KEY("organisation_id") REFERENCES "organisation"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
);
);  ''';

const createAnnouncementTable = ''' CREATE TABLE IF NOT EXISTS"announcement" (
	"id"	INTEGER NOT NULL UNIQUE,
	"to"	TEXT NOT NULL,
	"from"	TEXT NOT NULL,
	"message"	TEXT,
	"organisation_id"	TEXT NOT NULL,
	FOREIGN KEY("organisation_id") REFERENCES "organisation"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
 ''';
