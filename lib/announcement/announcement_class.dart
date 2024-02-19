import 'package:uuid/uuid.dart';

class Announcement {
  final id;
  final String depart;
  final String message;

  Announcement({required this.depart, required this.message})
      : id = Uuid().v4();
}
