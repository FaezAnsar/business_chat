import 'package:business_chat/announcement/announcement_class.dart';

import 'package:flutter/material.dart';

class AnnouncementProvider extends ChangeNotifier {
  final List<Announcement> announcementList = [];

  void addAnnouncement(Announcement announcement) {
    announcementList.add(announcement);
    notifyListeners();
  }

  void deleteAnnouncement(Announcement announcement) {
    announcementList.removeWhere((element) => element.id == announcement.id);
    notifyListeners();
  }

  String? depart;

  //  //String sender  --- applied after backend

  void departChange(String? value) {
    depart = value;
    notifyListeners();
  }
}
