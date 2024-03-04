import 'package:business_chat/announcement/announcement_pop_up.dart';
import 'package:business_chat/announcement/announcement_widget.dart';
import 'package:business_chat/crud/database.dart';
import 'package:business_chat/departments.dart';
import 'package:business_chat/error_dialogs/general_error_dialog.dart';
import 'package:business_chat/providers/announcement_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as devTools show log;

import 'package:provider/provider.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  late final BusinessService _businessService;
  //final _announcements = [];
  late final String _sender;
  List<AnnouncementDB> _announcements = [];

  Future<void> setAnnouncements() async {
    print('${_businessService.orgId},sett');
    final temp = (await _businessService.getAllAnnouncements()).toList();

    //_announcements = List<AnnouncementDB>.from(temp);
    // setState(() {
    //   _announcements = List<AnnouncementDB>.from(temp);
    // });
    _announcements = temp;
    print("announcements set");
  }

  @override
  void initState() {
    print("init state");
    _businessService = BusinessService();
    //setAnnouncements();
    super.initState();
  }

  Future<String> getSender() async {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    final employees = (await _businessService.getAllEmployees()).toList();
    final sender =
        employees.firstWhere((employee) => employee.email == userEmail);
    _sender = sender.name;
    return _sender;
  }

  @override
  Widget build(BuildContext context) {
    devTools.log("Announcement rebuilt");
    //devTools.log("${provider.depart.toString()}###");

    return Scaffold(
        appBar: AppBar(title: Text("Announcements")),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_alert_sharp),
            onPressed: () {
              String depart = 'Electrical';
              TextEditingController messageController = TextEditingController();
              devTools.log("popUp rebuilt");
              // final announcementSentProvider =
              //     Provider.of<AnnouncementProvider>(context, listen: false);
              // devTools.log("${announcementSentProvider.depart.toString()}+++");
              showDialog(
                  context: context,
                  builder: (context) => FutureBuilder(
                      future: getSender(),
                      builder: (context, s) {
                        return AlertDialog(
                          scrollable: true,
                          title: const Text("Announcement"),
                          content: Column(
                            children: [
                              Consumer<AnnouncementProvider>(
                                builder: (context, val, child) {
                                  return DropdownButton(
                                    hint: Text("Choose Recipient"),
                                    value: depart,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: departments.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      //devTools.log(value ?? "xx");
                                      setState(() {
                                        depart = value!;
                                      });
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
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  hintText: 'Type your text here...',
                                  // border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Send'),
                              onPressed: () async {
                                devTools.log("${depart.toString()}- - -");
                                if (depart == null &&
                                    messageController.text.isEmpty) {
                                  showErrorDialog(
                                      context, "Plz fill the empty fields");
                                } else if (depart == null) {
                                  showErrorDialog(
                                      context, "Plz select a department");
                                } else if (messageController.text.isEmpty) {
                                  showErrorDialog(
                                      context, "Plz enter a message");
                                } else {
                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Sending message..."),
                                    duration: Duration(milliseconds: 500),
                                  ));

                                  final announcement =
                                      await _businessService.createAnnouncement(
                                          to: depart,
                                          from: _sender,
                                          message: messageController.text,
                                          organisation_id:
                                              _businessService.orgId);
                                  // await setAnnouncements();

                                  setState(() {
                                    _announcements.add(announcement);
                                  });

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Announcement Sent!"),
                                    duration: Duration(milliseconds: 700),
                                  ));
                                }
                              },
                            ),
                          ],
                        );
                      }));
            }),
        body: FutureBuilder(
            future: setAnnouncements(),
            builder: (context, s) {
              switch (s.connectionState) {
                case ConnectionState.done:

                  // print("in pg,${value.announcementList}");
                  print("${_announcements},nooo");
                  print(_announcements.isEmpty);
                  return _announcements.isEmpty
                      ? Center(
                          child: Text(
                            "No Announcements yet.",
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : GridView.count(
                          childAspectRatio: 2.0,
                          crossAxisCount: 2,
                          children: _announcements.map((announcement) {
                            print(_announcements.length);
                            return AnnouncementWidget(
                                announcement: announcement);
                          }).toList(),
                        );
                case ConnectionState.none:
                  return Text(";((()))");
                default:
                  return CircularProgressIndicator();
              }
            }));
  }
}
//c8724941-02d1-4842-b24e-0a82efc4a800