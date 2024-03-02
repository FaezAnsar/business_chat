import 'package:business_chat/announcement/announcement_class.dart';
import 'package:business_chat/departments.dart';

import 'package:business_chat/error_dialogs/general_error_dialog.dart';

import 'package:business_chat/providers/announcement_provider.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devTools show log;

import 'package:provider/provider.dart';

Future<void> AnnouncementPopUp(BuildContext context) {
  TextEditingController messageController = TextEditingController();
  devTools.log("popUp rebuilt");
  final announcementSentProvider =
      Provider.of<AnnouncementProvider>(context, listen: false);
  devTools.log("${announcementSentProvider.depart.toString()}+++");
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            scrollable: true,
            title: const Text("Announcement"),
            content: Column(
              children: [
                Consumer<AnnouncementProvider>(
                  builder: (context, val, child) {
                    return DropdownButton(
                      hint: Text("Choose Recipient"),
                      value: val.depart,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: departments.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (value) {
                        //devTools.log(value ?? "xx");
                        val.departChange(value);
                      },
                    );
                  },
                ),
                TextFormField(
                  controller: messageController,
                  minLines: 10,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintText: 'Type your text here...',
                    // border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Send'),
                onPressed: () async {
                  devTools.log(
                      "${announcementSentProvider.depart.toString()}- - -");
                  if (announcementSentProvider.depart == null &&
                      messageController.text.isEmpty) {
                    showErrorDialog(context, "Plz fill the empty fields");
                  } else if (announcementSentProvider.depart == null) {
                    showErrorDialog(context, "Plz select a department");
                  } else if (messageController.text.isEmpty) {
                    showErrorDialog(context, "Plz enter a message");
                  } else {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Sending message..."),
                      duration: Duration(milliseconds: 500),
                    ));
                    announcementSentProvider.addAnnouncement(Announcement(
                        depart: announcementSentProvider.depart ?? "Error",
                        message: messageController.text));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Announcement Sent!"),
                      duration: Duration(milliseconds: 700),
                    ));
                  }
                },
              ),
            ],
          ));
}
