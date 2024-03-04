import 'package:business_chat/announcement/announcement_class.dart';
import 'package:business_chat/announcement/announcement_widget.dart';
import 'package:business_chat/crud/database.dart';
import 'package:business_chat/departments.dart';

import 'package:business_chat/error_dialogs/general_error_dialog.dart';

import 'package:business_chat/providers/announcement_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devTools show log;

import 'package:provider/provider.dart';

// Future<void> AnnouncementPopUp(BuildContext context) {
//   final user = FirebaseAuth.instance.currentUser;
//    String depart = '';
//   TextEditingController messageController = TextEditingController();
//   devTools.log("popUp rebuilt");
//   // final announcementSentProvider =
//   //     Provider.of<AnnouncementProvider>(context, listen: false);
//   // devTools.log("${announcementSentProvider.depart.toString()}+++");
//   return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//             scrollable: true,
//             title: const Text("Announcement"),
//             content: Column(
//               children: [
//                 Consumer<AnnouncementProvider>(
//                   builder: (context, val, child) {
//                     return DropdownButton(
//                       hint: Text("Choose Recipient"),
//                       value: depart,
//                       icon: const Icon(Icons.keyboard_arrow_down),
//                       items: departments.map((String items) {
//                         return DropdownMenuItem(
//                           value: items,
//                           child: Text(items),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         //devTools.log(value ?? "xx");
//                             setSta
//                         depart = value!;
//                       },
//                     );
//                   },
//                 ),
//                 TextFormField(
//                   controller: messageController,
//                   minLines: 10,
//                   maxLines: 10,
//                   keyboardType: TextInputType.multiline,
//                   decoration: InputDecoration(
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.transparent),
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.transparent)),
//                     hintText: 'Type your text here...',
//                     // border: OutlineInputBorder(),
//                   ),
//                 ),
//               ],
//             ),
//             actions: <Widget>[
//               TextButton(
//                 style: TextButton.styleFrom(
//                   textStyle: Theme.of(context).textTheme.labelLarge,
//                 ),
//                 child: const Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                 style: TextButton.styleFrom(
//                   textStyle: Theme.of(context).textTheme.labelLarge,
//                 ),
//                 child: const Text('Send'),
//                 onPressed: () async {
//                   devTools.log(
//                       "${announcementSentProvider.depart.toString()}- - -");
//                   if (announcementSentProvider.depart == null &&
//                       messageController.text.isEmpty) {
//                     showErrorDialog(context, "Plz fill the empty fields");
//                   } else if (announcementSentProvider.depart == null) {
//                     showErrorDialog(context, "Plz select a department");
//                   } else if (messageController.text.isEmpty) {
//                     showErrorDialog(context, "Plz enter a message");
//                   } else {
//                     Navigator.of(context).pop();
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text("Sending message..."),
//                       duration: Duration(milliseconds: 500),
//                     ));
//                     announcementSentProvider.addAnnouncement({
//                       fromColumn: await getSender(),
//                       toColumn: announcementSentProvider.depart ?? "Error",
//                       messageColumn: messageController.text
//                     });
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text("Announcement Sent!"),
//                       duration: Duration(milliseconds: 700),
//                     ));
//                   }
//                 },
//               ),
//             ],
//           ));
// }

// // final _businessService = BusinessService();
// // Future<String> getSender() async {
// //   String _sender = '';
// //   final userEmail = FirebaseAuth.instance.currentUser!.email;
// //   final employees = (await _businessService.getAllEmployees()).toList();
// //   final sender =
// //       employees.firstWhere((employee) => employee.email == userEmail);
// //   _sender = sender.name;
// //   return _sender;

