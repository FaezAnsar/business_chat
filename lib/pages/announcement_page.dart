import 'package:business_chat/pop_ups/announcement_pop_up.dart';
import 'package:business_chat/announcement/announcement_widget.dart';
import 'package:business_chat/providers/announcement_provider.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as devTools show log;

import 'package:provider/provider.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    devTools.log("Announcement rebuilt");
    //devTools.log("${provider.depart.toString()}###");

    return Scaffold(
      appBar: AppBar(title: Text("Announcements")),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_alert_sharp),
          onPressed: () {
            AnnouncementPopUp(context);
          }),
      body: Consumer<AnnouncementProvider>(builder: (context, value, child) {
        return value.announcementList.isEmpty
            ? Center(
                child: Text(
                  "No Announcements yet.",
                  style: TextStyle(fontSize: 18),
                ),
              )
            : GridView.count(
                childAspectRatio: 2.0,
                crossAxisCount: 2,
                children: value.announcementList.map((announcement) {
                  return AnnouncementWidget(announcement: announcement);
                }).toList(),
              );
      }),
    );
  }
}
