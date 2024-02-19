import 'package:business_chat/announcement/announcement_class.dart';
import 'package:business_chat/providers/announcement_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnnouncementWidget extends StatelessWidget {
  final Announcement announcement;
  const AnnouncementWidget({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _controller.text = announcement.message;
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
                              context
                                  .read<AnnouncementProvider>()
                                  .deleteAnnouncement(announcement);
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
                  builder: (context) => AlertDialog(
                        scrollable: true,
                        title: const Text("Announcement"),
                        content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("To:${announcement.depart}"),
                              const Text("From:(After backend integration)"),
                              TextFormField(
                                readOnly: true,
                                controller: _controller,
                                minLines: 10,
                                maxLines: 10,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
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
                      ));
            },
            title: Center(
                child: Icon(
              Icons.crisis_alert,
              color: Colors.redAccent.shade700,
            ))));
  }
}
