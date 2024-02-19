import 'package:business_chat/pages/contact_page.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  final List<Contact> contacts = [];

  ContactProvider() {
    List<String> keyList = m.keys.toList();
    for (int i = 0; i < m.length; i++) {
      String key = keyList[i];
      contacts.add(Contact(name: key, role: m[key] ?? 'N?A'));
    }
  }

  void press(String id) {
    for (Contact item in contacts) {
      if (item.id == id) {
        item.press();
        notifyListeners();
      }
    }
  }
}
