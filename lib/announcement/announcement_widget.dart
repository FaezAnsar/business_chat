import 'package:business_chat/crud/cloud_class.dart';
import 'package:business_chat/crud/cloud_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnnouncementWidget extends StatefulWidget {
  final CloudAnnouncement announcement;
  AnnouncementWidget({super.key, required this.announcement});

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  final _businessService = FirebaseCloudStorage();

  late final String _sender;

  Future<String> getSender() async {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    final employees = (await _businessService.getAllEmployees(
            organisationId: widget.announcement.organisationId))
        .toList();
    final sender =
        employees.firstWhere((employee) => employee.email == userEmail);
    _sender = sender.name;
    return _sender;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _controller.text = widget.announcement.message;
    return Card(
        child: ListTile(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Delete Announcement"),
                        content: Text("U sure??"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // context
                              //     .read<AnnouncementProvider>()
                              //     .deleteAnnouncement(announcement);
                              _businessService.deleteAnnouncement(
                                  announcement: widget.announcement);
                              setState(() {});
                            },
                            child: Text("Yes"),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("No")),
                        ],
                      ));
            },
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => FutureBuilder(
                      future: getSender(),
                      builder: (context, s) {
                        switch (s.connectionState) {
                          case ConnectionState.done:
                            return AlertDialog(
                              scrollable: true,
                              title: const Text("Announcement"),
                              content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("To:${widget.announcement.to}"),
                                    Text("From:$_sender"),
                                    TextFormField(
                                      readOnly: true,
                                      controller: _controller,
                                      minLines: 10,
                                      maxLines: 10,
                                      keyboardType: TextInputType.multiline,
                                      decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),

                                        // border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ]),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Ok"))
                              ],
                            );
                          default:
                            return CircularProgressIndicator();
                        }
                      }));
            },
            title: Center(
                child: Icon(
              Icons.crisis_alert,
              color: Colors.redAccent.shade700,
            ))));
  }
}
