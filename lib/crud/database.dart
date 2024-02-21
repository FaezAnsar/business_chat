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
      'Organistion, ID = $id,Name = $name,Role = $role,EmployeeCnic  = $employee_cnic,email = $email,OrganisationId = $organisation_id';

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
	"email"	TEXT,
	PRIMARY KEY("id")
);
);''';

const createEmployeeTable = '''CREATE TABLE "employee" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT,
	"role"	TEXT NOT NULL,
	"employee_cnic"	INTEGER NOT NULL,
	"email"	TEXT NOT NULL,
	"organisation_id"	TEXT NOT NULL,
	FOREIGN KEY("organisation_id") REFERENCES "organisation"("id"),
	PRIMARY KEY("id")
);
);
);  ''';
