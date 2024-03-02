import 'dart:async';

import 'package:business_chat/crud/database_exceptions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

class BusinessService {
  Database? _db;

  List<EmployeeDB> _employees = [];
  String? _orgId;
  OrganisationDB? _organisation;

  set orgId(String id) => _orgId = id;
  String get orgId => _orgId ?? '';
  static final BusinessService _shared = BusinessService._sharedInstance();

  BusinessService._sharedInstance();
  factory BusinessService() => _shared;

  Future<Iterable<EmployeeDB>> getAllEmployees() async {
    await _ensureDbIsOpen();
    final db = _getDataBaseOrThrow();

    final employees = await db.query(employeeTable, orderBy: idColumn);
    print(_orgId);
    return employees
        .map((employee) => (employee[organisationIdColumn] == _orgId)
            ? EmployeeDB.fromRow(employee)
            : null)
        .whereNotNull();

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
        await db.delete(employeeTable, where: 'id=?', whereArgs: [id]);
    if (deletedCount != 1) throw CouldNotDeleteEmployee();
    _employees.removeWhere((employee) => employee.id == id);
  }

  Future<EmployeeDB?> createEmployee(
      {required String name,
      required String role,
      required int employeeCnic,
      required String email,
      required String organisationId}) async {
    final employeeMap = {
      nameColumn: name,
      roleColumn: role,
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
      nameColumn: name,
      ownerNameColumn: ownerName,
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

      await db.execute(createOrganisationTable);
      await db.execute(createEmployeeTable);
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
